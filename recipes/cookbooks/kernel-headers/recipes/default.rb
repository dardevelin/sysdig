#
# Cookbook Name:: kernel-headers
# Recipe:: default

require 'chef/shell_out'

compiletime = node['kernel_headers']['compiletime']

case node['platform']
when "ubuntu","debian"

  # on apt-based platforms when first provisioning we need to force
  # apt-get update at compiletime if we are going to try to install at compiletime
  if node['platform_family'] == "debian"
    execute "apt-get-update" do
      command "apt-get update"
      action :nothing
      # tip: to suppress this running every time, just use the apt cookbook
      not_if do
        ::File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
        ::File.mtime('/var/lib/apt/periodic/update-success-stamp') > Time.now - 86400*2
      end
    end.run_action(:run) if compiletime
  end

  packages = case node['platform_family']
    when "debian","ubuntu"
      %w{linux-headers-`uname\ -r`}
    end

  packages.each do |pkg|
    r = package pkg do
      action ( compiletime ? :nothing : :install )
    end
    r.run_action(:install) if compiletime
  end

end
