# insert_after :admin_tabs,                 'admin/hooks/wholesale_tab'
Deface::Override.new(
  :virtual_path => "layouts/admin",
  :name => "admin-wholesale-tab",
  :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
  :partial => "admin/hooks/wholesale_tab",
  :disabled => false
)
