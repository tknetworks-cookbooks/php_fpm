#
# Author:: Ken-ichi TANABE (<nabeken@tknetworks.org>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# This LWRP supports whyrun mode
def whyrun_supported?
  true
end

action :create do
  if new_resource.template
    Chef::Log.debug('Template attribute provided, all other attributes ignored.')

    resource = template "#{node['php_fpm']['conf_dir']}/pool.d/#{new_resource.name}.conf" do
      source new_resource.template
      owner 'root'
      group node['etc']['passwd']['root']['gid']
      mode  '0440'
      variables :user => new_resource.user,
                :group => new_resource.group,
                :name => new_resource.name,
                :variables => new_resource.variables
      action :nothing
      notifies :restart, "service[#{node['php_fpm']['service']['name']}]"
    end
  else
    resource = template "#{node['php_fpm']['conf_dir']}/pool.d/#{new_resource.name}.conf" do
      source 'pool.conf.erb'
      cookbook 'php_fpm'
      owner 'root'
      group node['etc']['passwd']['root']['gid']
      mode  '0440'
      variables :user => new_resource.user,
                :group => new_resource.group,
                :name => new_resource.name,
                :variables => new_resource.variables
      action :nothing
      notifies :restart, "service[#{node['php_fpm']['service']['name']}]"
    end
  end
  resource.run_action(:create)
  new_resource.updated_by_last_action(true) if resource.updated_by_last_action?
end

action :remove do
  resource = file "#{node['php_fpm']['conf_dir']}/pool.d/#{new_resource.name}.conf" do
    action :nothing
    notifies :restart, "service[#{node['php_fpm']['service']}]"
  end
  resource.run_action(:delete)
  new_resource.updated_by_last_action(true) if resource.updated_by_last_action?
end
