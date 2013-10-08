module Spree
  module Admin
    class SalesReportGroupVariantsController < Spree::Admin::ResourceController
      belongs_to 'spree/sales_report_group'
      before_filter :load_data, only: [:new, :create, :edit, :update]

      private

      def load_data
      end

      def collection_url
        if @sales_report_group_variant.sales_report_group.present?
          spree.admin_sales_report_group_path(@sales_report_group_variant.sales_report_group)
        else
          super
        end
      end

      def find_resource
        if parent && parent.respond_to?(controller_name)
          parent.send(controller_name).find(params[:id])
        else
          model_class.find(params[:id])
        end
      end
    end
  end
end
