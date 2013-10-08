Deface::Override.new(
  virtual_path: "spree/admin/shared/_configuration_menu",
  name: "add_sales_report_groups_tab",
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
  text: "<li<%= ' class=active' if controller.controller_name =~ /^sales_report_/ %>><%= link_to \"Sales report groups\", spree.admin_sales_report_groups_path %></li>"
)
