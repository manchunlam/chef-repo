#
# Cookbook Name:: foo
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby '1.9.3-p551' do
  ruby_version '1.9.3-p551'
  global true
end

rbenv_gem 'bundler' do
  ruby_version '1.9.3-p551'
end
