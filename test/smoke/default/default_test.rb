# # encoding: utf-8

# Inspec test for recipe chef-server-test::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
#
# unless os.windows?
#   # This is an example test, replace with your own test.
#   describe user('root'), :skip do
#     it { should exist }
#   end
# end
#
# # This is an example test, replace it with your own test.
# describe port(80), :skip do
#   it { should_not be_listening }
# end


#Test that the chef-server installation package has been downloaded
describe file("/tmp/kitchen/cache/chef-server-core-12.15.7-1.el7.x86_64.rpm") do
  it {should exist}
end

#Ensure that the chef-server package has been installed
describe package('chef-server-core') do
  it {should be_installed}
end

#Check that the admin private key has been generated
describe file("/admin.pem") do
  it {should exist}
end

#Check that the organization private key has been created
describe file("/orgPrivateKey.pem") do
  it {should exist}
end

#Check that chef-manage has been installed
describe package('chef-manage') do
  it {should be_installed}
end
