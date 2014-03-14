bash "set_hostname" do
  user "root"
  code <<-EOH
    hostname slender-api.local
  EOH
end