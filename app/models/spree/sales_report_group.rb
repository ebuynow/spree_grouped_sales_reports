module Spree
  class SalesReportGroup < ActiveRecord::Base
    attr_accessible :description, :name

    has_many :sales_report_group_variants, dependent: :destroy, class_name: 'Spree::SalesReportGroupVariant'

    validates :name, presence: true
  end
end
