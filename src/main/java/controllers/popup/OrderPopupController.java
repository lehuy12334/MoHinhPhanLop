package controllers.popup;

import controllers.PrintOrderController;
import controllers.popup.order.FoodItemController;
import controllers.popup.order.OrderItemController;
import dao.EmployeeDao;
import dao.OrderDao;
import dao.OrderItemDao;
import dao.ShipmentDao;
import dao.TableDao;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import main.SessionManager;
import models.Employee;
import models.Order;
import models.OrderItem;
import models.Shipment;
import models.Table;
import utils.OrderStatus;
import utils.OrderType;
import utils.ShipmentStatus;
import utils.TableStatus;
import views.popup.AddOrderPopupView;
import views.popup.EditOrderPopupView;
import views.popup.ShipmentPopupView;
import views.popup.ToppingPopupView;


public class OrderPopupController {

    OrderDao orderDao = new OrderDao();
    EmployeeDao employeeDao = new EmployeeDao();
    ShipmentDao shipmentDao = new ShipmentDao();
    TableDao tableDao = new TableDao();
    OrderItemDao orderItemDao = new OrderItemDao();
    FoodItemController foodItemController = new FoodItemController();
    OrderItemController orderItemController = new OrderItemController();
    ToppingPopupController toppingPopupController = new ToppingPopupController();
    ShipmentPopupController shipmentPopupController = new ShipmentPopupController();
    PrintOrderController printOrderController = new PrintOrderController();
    DecimalFormat formatter = new DecimalFormat("###,###,###");
    JFrame previousView;

    public void updateAmount(EditOrderPopupView view, Order order) {
        order.setTotalAmount(orderItemController.getTotalAmount());
        view.getLbStatus().setText(order.getStatus().getName());
        view.getLbDiscount().setText(order.getDiscount() + "");
        view.getLbPaidAmount().setText(formatter.format(order.getPaidAmount()));
        view.getLbFinalAmount().setText(formatter.format(order.getFinalAmount()));
        view.getLbTotalAmount().setText(formatter.format(order.getTotalAmount()));
    }

    public boolean addOrder(AddOrderPopupView view) throws Exception {
        Order e = new Order();
        Table table = (Table) view.getTbComboBoxModel().getSelectedItem();
        OrderType type = OrderType.getByName(view.getCboType().getSelectedItem().toString());
        Employee employee = SessionManager.getSession().getEmployee();
        int discount = (int) view.getSpnDiscount().getValue();
        if (table == null) {
            throw new Exception("H???t b??n");
        }
        if (discount < 0 || discount > 100) {
            throw new Exception("Discount ph???i n???m trong kho???ng 0-100");
        }
        if (employee == null) {
            throw new Exception("B???n ch??a ????ng nh???p");
        }
        if (type == OrderType.LOCAL) {
            if (tableDao.get(table.getId()).getStatus() != TableStatus.FREE) {
                throw new Exception("B??n n??y ??ang ph???c v???");
            }
            table.setStatus(TableStatus.SERVING);
        }

        Order order = new Order();
        order.setEmployee(employee);
        order.setTable(table);
        order.setStatus(OrderStatus.UNPAID);
        order.setType(type);
        order.setDiscount(discount);
        orderDao.save(order);
        tableDao.update(table);
        return true;
    }

    public boolean editOrder(EditOrderPopupView view, Order order) throws Exception {
        if (order.getTable() == null) {
            throw new Exception("H???t b??n");
        }
        if (order.getDiscount() < 0 || order.getDiscount() > 100) {
            throw new Exception("Discount ph???i n???m trong kho???ng 0-100");
        }
        if (order.getEmployee() == null) {
            throw new Exception("Ch???n nh??n vi??n");
        }
        if (order.getType() == OrderType.LOCAL) {
            order.getTable().setStatus(TableStatus.SERVING);
        } else {
            order.getTable().setStatus(TableStatus.FREE);
        }
        if (order.getPaidAmount() == order.getFinalAmount()) {
            order.setStatus(OrderStatus.PAID);
        }
        for (OrderItem orderItem : orderItemController.getOrderItems()) {
            if (orderItem.getQuantity() <= 0) {
                orderItemDao.delete(orderItem);
            } else {
                orderItemDao.save(orderItem);
            }
        }
        if (order.getFinalAmount() <= 0 || order.getFinalAmount() > order.getPaidAmount()) {// Ch??a thanh to??n 
            order.setStatus(OrderStatus.UNPAID);
            order.setPayDate(null);
        } else if (order.getStatus() == OrderStatus.UNPAID || order.getPayDate() == null) {
            // Thanh to??n
            order.setStatus(OrderStatus.PAID);
            order.setPayDate(new Timestamp(System.currentTimeMillis()));
            order.getTable().setStatus(TableStatus.FREE); // Tr??? b??n
        }
        order.setTotalAmount(orderItemController.getTotalAmount());
        orderDao.update(order);
        tableDao.update(order.getTable());
        if (order.getType() != OrderType.ONLINE) {
            shipmentDao.deleteById(order.getId());//X??a ????n ship
        }
        return true;
    }

    public void add(AddOrderPopupView view, SuccessCallback sc, ErrorCallback ec) {
        if (previousView != null && previousView.isDisplayable()) {
            previousView.requestFocus();
            return;
        }
        previousView = view;
        view.setVisible(true);
        view.getBtnCancel().addActionListener(evt -> view.dispose());
        try {
            for (Table table : tableDao.getAll()) {
                if (table.getStatus() == TableStatus.FREE) {
                    view.getTbComboBoxModel().addElement(table);
                }
            }
            for (OrderType ot : OrderType.values()) {
                view.getCboType().addItem(ot.getName());
            }
        } catch (Exception e) {
            view.dispose();
            ec.onError(e);
            return;
        }
        view.getBtnOK().addActionListener(evt -> {
            try {
                addOrder(view);
                view.dispose();
                view.showMessage("T???o h??a ????n th??nh c??ng!");
                sc.onSuccess();
            } catch (Exception ex) {
                ec.onError(ex);
            }
        });

    }

    public void edit(EditOrderPopupView view, Order order, SuccessCallback sc, ErrorCallback ec) {
        if (previousView != null && previousView.isDisplayable()) {
            previousView.requestFocus();
            return;
        }
        previousView = view;
        Employee currentLogin = SessionManager.getSession().getEmployee();
        if (order.getEmployee() == null) {
            order.setEmployee(currentLogin);
        }
        if (!order.getEmployee().equals(currentLogin) && order.getEmployee().getPermission().compare(currentLogin.getPermission()) > 0) {
            ec.onError(new Exception("B???n kh??ng c?? quy???n s???a h??a ????n n??y"));
            view.dispose();
            return;
        }
        view.setVisible(true);
        view.getBtnCancel().addActionListener(evt -> view.dispose());
        orderItemController.setPanelOrderItem(view.getPnlOrderItem());
        orderItemController.setIdOrder(order.getId());
        orderItemController.setOnQuantityChange(() -> {
            updateAmount(view, order);
        });
        foodItemController.setPanelFoodCategory(view.getPnlFoodCategory());
        foodItemController.setPanelFoodItem(view.getPnlFoodItem());

        if (order.getEmployee() != null) {
            view.getLbEmployeeName().setText(order.getEmployee().getName());
        }
        view.getLbIdOrder().setText(order.getId() + "");
        try {
            for (Table table : tableDao.getAll()) { // Hi???n th??? danh s??ch b??n
                if (table.getStatus() == TableStatus.FREE || table.getId() == order.getIdTable()) {
                    view.getTbComboBoxModel().addElement(table);
                }
            }
            for (OrderType ot : OrderType.values()) { // Hi???n th??? lo???i h??a ????n
                view.getCboType().addItem(ot.getName());
            }
            orderItemController.setOrderItems(orderItemDao.getByIdOrder(order.getId()));
            foodItemController.renderCategory(foodItem -> {//Hi???n th??? danh s??ch m??n ??n
                toppingPopupController.add(new ToppingPopupView(), foodItem, orderItem -> {
                    orderItemController.addOrderItem(orderItem);// Th??m v??o danh s??ch order
                    updateAmount(view, order);
                });
            });
            view.getTbComboBoxModel().setSelectedItem(order.getTable());
            view.getSpnDiscount().setValue(order.getDiscount());
            view.getCboType().setSelectedItem(order.getType().getName());
            view.getLbDiscount().setText(order.getDiscount() + "");

        } catch (Exception e) {
            view.dispose();
            ec.onError(e);
            return;
        }
        updateAmount(view, order);
        view.getBtnOK().setText("C???p nh???t");
        view.getCboType().addActionListener(evt -> {
            order.setType(OrderType.getByName(view.getCboType().getSelectedItem().toString()));
        });
        view.getSpnDiscount().addChangeListener(evt -> { // Thay gi?? tr???
            order.setDiscount((int) view.getSpnDiscount().getValue());
            updateAmount(view, order);
        });
        view.getCboTable().addActionListener(evt -> { // Thay b??n
            try {
                Table nTable = (Table) view.getTbComboBoxModel().getSelectedItem(),
                        cTable = order.getTable();
                if (nTable == null || (cTable != null && nTable.getId() == cTable.getId())) {
                    return;
                }
                cTable.setStatus(TableStatus.FREE);
                nTable.setStatus(TableStatus.SERVING);
                order.setTable(nTable);
                tableDao.update(cTable);
                tableDao.update(nTable);
            } catch (Exception ex) {
                ec.onError(ex);
            }
        });
        view.getBtnOK().addActionListener(evt -> {
            try {
                editOrder(view, order);
//                view.dispose();
                view.showMessage("S???a h??a ????n th??nh c??ng!");
                updateAmount(view, order);
                sc.onSuccess();
            } catch (Exception ex) {
                ec.onError(ex);
            }
        });

        view.getBtnPaid().addActionListener(evt -> {
            try {
                String rawInput = JOptionPane.showInputDialog(null, "Nh???p s??? ti???n thanh to??n!", order.getPaidAmount());
                if (rawInput == null) {
                    return;
                }
                int paidAmount = Integer.parseInt(rawInput);
                if (order.getFinalAmount() > paidAmount) {
                    JOptionPane.showMessageDialog(null, "B???n c??n ph???i thanh to??n " + formatter.format(order.getFinalAmount() - paidAmount) + " VND");
                } else {
                    JOptionPane.showMessageDialog(null, "B???n ???? thanh to??n xong");
                }
                order.setPaidAmount(paidAmount);
                updateAmount(view, order);
            } catch (Exception e) {
                ec.onError(e);
            }
        });
        view.getBtnShipManager().addActionListener(evt -> {
            if (order.getType() != OrderType.ONLINE) {
                view.showError("B???n ch??? c?? th??? ship ????n online");
                return;
            }
            shipmentPopupController.add(new ShipmentPopupView(), order.getId(), () -> view.showMessage("T???o / s???a ????n ship th??nh c??ng!"), view::showError);
        });
//        view.getBtnPrintOrder().addActionListener(evt -> {
//            try {
//                printOrderController.print(order.getId());
//            } catch (Exception e) {
//                view.showError("Kh??ng th??? in h??a ????n");
//            }
//        });
        view.getBtnCancelOrder().addActionListener(evt -> {
            try {
                int value = JOptionPane.showConfirmDialog(null, "B???n c?? ch???c mu???n h???y h??a ????n?");
                if (value != JOptionPane.YES_OPTION) {
                    return;
                }
                order.setStatus(OrderStatus.CANCEL);
                Shipment shipment = shipmentDao.get(order.getId());
                if (shipment != null) {
                    shipment.setStatus(ShipmentStatus.CANCELLED);
                    shipmentDao.update(shipment); // H???y ????n ship
                }
                order.getTable().setStatus(TableStatus.FREE);
                orderDao.update(order);
                tableDao.update(order.getTable());
                view.dispose();
                sc.onSuccess();
            } catch (Exception e) {
                view.showError(e);
            }
        });

    }
}
