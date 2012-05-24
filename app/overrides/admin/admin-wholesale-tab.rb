# insert_after :admin_tabs,                 'admin/hooks/wholesale_tab'
Deface::Override.new(
  :virtual_path => "spree/layouts/admin",
  :name => "admin-wholesale-tab",
  :insert_bottom => "[data-hook='admin_tabs']",
  :partial => "spree/admin/hooks/wholesale_tab",
  :disabled => false
)
