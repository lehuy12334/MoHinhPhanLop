package views.admin;

import javax.swing.DefaultComboBoxModel;
import models.FoodCategory;


public class FoodCategoryManagerView extends ManagerPaneView<FoodCategory> {

    String[] list = {"ID", "name"};

    public FoodCategoryManagerView() {
        super();
        setTableModel();
        renderTable();
    }

    @Override
    public void setTableModel() {
        tableModel.addColumn("ID");
        tableModel.addColumn("Tên loại");
        this.getCboSearchField().setModel(new DefaultComboBoxModel(list));
    }
}
