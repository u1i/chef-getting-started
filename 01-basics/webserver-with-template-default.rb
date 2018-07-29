# mkdir cookbooks
# chef generate cookbook cookbooks/learn_chef_apache2
# chef generate template cookbooks/learn_chef_apache2 index.html
# chef-client --local-mode --runlist 'recipe[learn_chef_apache2]'

apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

package 'apache2'

service 'apache2' do
  supports status: true
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end
