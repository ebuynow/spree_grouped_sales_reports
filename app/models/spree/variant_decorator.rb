Spree::Variant.class_eval do
  has_many :report_group_variants, dependent: :destroy, class_name: 'Spree::SalesReportGroupVariant'
end
