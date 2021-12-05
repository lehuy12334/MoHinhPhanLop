package views.admin;

import javax.swing.DefaultComboBoxModel;
import models.FoodItem;


public class FoodItemManagerView extends ManagerPaneView<FoodItem> {

    String[] list = {"ID", "name", "idCategory"};

    public FoodItemManagerView() {
        super();
        setTableModel();
        renderTable();
    }

    @Override
    public void setTableModel() {
        tableModel.addColumn("ID");
        tableModel.addColumn("Tên Món");
        tableModel.addColumn("Mô tả");
        tableModel.addColumn("Link ảnh");
        tableModel.addColumn("Tên đv");
        tableModel.addColumn("Giá đv");
        tableModel.addColumn("Mã loại");
        this.getCboSearchField().setModel(new DefaultComboBoxModel(list));
    }
}
