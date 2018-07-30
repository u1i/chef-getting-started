# depends 'git'
# depends 'poise-python'

package 'git'

git_client 'default' do
  action :install
end

directory '/tmp/mydir' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

git '/tmp/mydir' do
  repository 'https://github.com/u1i/yoisho.git'
  revision 'master'
  action :sync
end

python_runtime '2'
python_virtualenv '/opt/myapp/.env'

#python_package 'Django' do
#  version '1.8'
#end

pip_requirements '/tmp/sausack/yoisho-account-oauth-client'
