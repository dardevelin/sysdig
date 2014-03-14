# configure and restart supervisord
# Author: Juni Samos jsamos@gmail.com

template "/etc/supervisor.d/sqs.conf" do
  source "sqs.erb"
end