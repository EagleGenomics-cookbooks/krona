#
# Cookbook:: krona
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'git'

git 'checkout krona src code' do
  destination node['krona']['src_dir']
  repository node['krona']['src_repo']
  revision node['krona']['version']
  action 'export'
end
