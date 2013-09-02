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

describe_recipe 'php_fpm_test::www_template' do
  it 'configures www template pool' do
    file("#{node['php_fpm']['conf_dir']}/pool.d/www_template.conf").must_include '[www_template]'
    file("#{node['php_fpm']['conf_dir']}/pool.d/www_template.conf").must_include 'listen = /var/run/php5-fpm-www_template.sock'
    file("#{node['php_fpm']['conf_dir']}/pool.d/www_template.conf").must_include 'THIS IS A CUSTOM TEMPLATE'
  end
end
