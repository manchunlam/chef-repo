#
# Cookbook Name:: vps
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'nginx' do
  action :install
end

service 'nginx' do
  action [:enable, :start]
end

# add the EPEL repo
yum_repository 'epel' do
  description 'Extra Packages for Enterprise Linux'
  mirrorlist 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch'
  gpgkey 'http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
  action :create
end

# yum_package 'centos-release-SCL' do
#   action :install
# end

cookbook_file 'enable-ruby193.sh' do
  source 'enable-ruby193.sh'
  path '/etc/profile.d/enable-ruby193.sh'
  mode '0644'
end

cookbook_file '/root/foobar.txt' do
  source 'foobar.txt'
  mode '0644'
end
