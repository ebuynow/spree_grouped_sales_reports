class CreateSalesReportGroupVariants < ActiveRecord::Migration
  def change
    create_table :spree_sales_report_group_variants do |t|
      t.references :variant
      t.references :sales_report_group

      t.timestamps
    end
    add_index :spree_sales_report_group_variants, [:variant_id, :sales_report_group_id], unique: true, name: 'index_spree_sales_report_group_v_on_s'
  end
end
