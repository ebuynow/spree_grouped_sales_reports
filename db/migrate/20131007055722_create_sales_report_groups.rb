class CreateSalesReportGroups < ActiveRecord::Migration
  def change
    create_table :spree_sales_report_groups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
