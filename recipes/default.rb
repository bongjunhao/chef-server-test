#
# Cookbook Name:: chef-server
# Recipe:: default
#

package_url = node['chef-server']['url']
package_name = ::File.basename(package_url)
package_local_path = "#{Chef::Config[:file_cache_path]}/#{package_name}"

userName = node['userName']
firstName = node['firstName']
lastName = node['lastName']
email = node['email']
password = node['password']
privateKeyName = node['privateKeyName']

shortName = node['shortName']
fullName = node['fullName']
orgPrivateKeyName = node['orgPrivateKeyName']

# package is remote, download it to '/tmp/kitchen/cache/chef-server-core-12.15.7-1.el7.x86_64.rpm'
remote_file package_local_path do
  source package_url
end

#Install the package and execute 'chef-server-ctl reconfigure' everytime installation is done
package package_name do
  source package_local_path
  provider Chef::Provider::Package::Rpm
  notifies :run, 'execute[reconfigure-chef-server]', :immediately
  notifies :run, 'execute[create-admin-user]', :immediately
  notifies :run, 'execute[create-organization]', :immediately
end

# reconfigure the installation, do not execute if no installation done (i.e chef-server is already installed) - ensures idempotency
execute 'reconfigure-chef-server' do
  command 'chef-server-ctl reconfigure'
  action :nothing
end

#Create one admin user
execute 'create-admin-user' do
  #Command to create the admin user
  command "sudo chef-server-ctl user-create #{userName} #{firstName} #{lastName} #{email} #{password} --filename #{privateKeyName}.pem"
  action :nothing
end

#Create the initial organization
execute 'create-organization' do
  #Command to create organisation
  command "sudo chef-server-ctl org-create #{shortName} #{fullName} --association #{userName} --filename #{orgPrivateKeyName}.pem"
  action :nothing
end
