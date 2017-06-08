default['chef-server']['url'] = \
  'https://packages.chef.io/files/stable/chef-server/12.15.7/el/7/'\
  'chef-server-core-12.15.7-1.el7.x86_64.rpm'

#attributes to create admin user
default['userName'] = 'admin'
default['email'] = 'bongjunhao@gmail.com'
default['firstName'] = 'Jun Hao'
default['lastName'] = 'Bong'
default['password'] = 'P@5sw0rD'
default['privateKeyName'] = 'admin'

#attributes to create organization
default['shortName'] = 'ocst'
default['fullName'] = 'oracle-chef-server-testing'
default['orgPrivateKeyName'] = 'orgPrivateKey'
