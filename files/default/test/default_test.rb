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
require 'minitest/spec'

describe_recipe 'php_fpm::default' do
  it 'installs php-fpm package' do
    package(node['php_fpm']['package']).must_be_installed
  end

  it 'enables/starts php-fpm service' do
    service(node['php_fpm']['service']['pattern']).must_be_running
    service(node['php_fpm']['service']['name']).must_be_enabled
  end

  it 'configures www pool' do
    file("#{node['php_fpm']['conf_dir']}/pool.d/www.conf").must_include '[www]'
    file("#{node['php_fpm']['conf_dir']}/pool.d/www.conf").must_include 'listen = /var/run/php5-fpm-www.sock'
  end
end
