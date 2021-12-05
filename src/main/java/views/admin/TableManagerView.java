package views.admin;

import javax.swing.DefaultComboBoxModel;
import models.Table;


public class TableManagerView extends ManagerPaneView<Table> {

    String[] list = {"ID", "name"};

    public TableManagerView() {
        super();
        setTableModel();
        renderTable();
    }

    @Override
    public void setTableModel() {
        tableModel.addColumn("ID");
        tableModel.addColumn("Tên bàn");
        tableModel.addColumn("Trạng thái");
        this.getCboSearchField().setModel(new DefaultComboBoxModel(list));
    }
}
