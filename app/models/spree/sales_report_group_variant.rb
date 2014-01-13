module Spree
  class SalesReportGroupVariant < ActiveRecord::Base
    belongs_to :variant, class_name: 'Spree::Variant'
    belongs_to :sales_report_group, class_name: 'Spree::SalesReportGroup'

    validates :variant, :sales_report_group, presence: true
    validates :variant_id, uniqueness: { scope: :sales_report_group_id }
  end
end
