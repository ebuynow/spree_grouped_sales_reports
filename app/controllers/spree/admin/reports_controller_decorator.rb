Spree::Admin::ReportsController.class_eval do
  def grouped_sales
    params[:q] = {} unless params[:q]

    if params[:q][:created_at_gt].blank?
      params[:q][:created_at_gt] = Time.zone.now.beginning_of_month
    else
      params[:q][:created_at_gt] = Time.zone.parse(params[:q][:created_at_gt]).beginning_of_day rescue Time.zone.now.beginning_of_month
    end

    if params[:q] && !params[:q][:created_at_lt].blank?
      params[:q][:created_at_lt] = Time.zone.parse(params[:q][:created_at_lt]).end_of_day rescue ""
    end

    @order_states = %w(cart address delivery payment complete resumed canceled)
    if params[:q][:order_state_in]
      @order_states_selected = [params[:q][:order_state_in]].flatten.compact.delete_if(&:blank?)
    else
      @order_states_selected = %w(delivery payment complete resumed canceled)
    end

    initial_hash = Hash[@order_states_selected.map { |s| [s, 0] }]

    @search = Spree::LineItem.joins(:order).ransack(params[:q])
    @line_items = @search.result

    @grouped_totals = {}

    Spree::SalesReportGroup.all.each do |group|
      @grouped_totals[group.id] = { name: group.name, description: group.description, items: {} } unless @grouped_totals.has_key?(group.id)
      group.sales_report_group_variants.each do |group_variant|
        @grouped_totals[group.id][:items][group_variant.id] = { sku: group_variant.variant.sku, data: initial_hash.clone } unless @grouped_totals[group.id][:items].has_key?(group_variant.id)
        @order_states_selected.each do |state|
          @grouped_totals[group.id][:items][group_variant.id][:data][state] = @line_items.where(variant_id: group_variant.variant_id, spree_orders: { state: state }).sum('quantity')
        end
      end
    end
  end
end

Spree::Admin::ReportsController.add_available_report!(:grouped_sales)
