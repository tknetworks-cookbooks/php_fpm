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
require 'spec_helper'

describe 'php_fpm::default' do
  include_context 'debian'

  let (:chef_run) {
    ChefSpec::ChefRunner.new() do |node|
      set_node(node)
    end
  }

  before do
    chef_run.converge('php_fpm::default')
  end

  it 'should install php-fpm' do
    expect(chef_run).to install_package chef_run.node['php_fpm']['package']
  end

  it 'should enable/start php-fpm' do
    expect(chef_run).to set_service_to_start_on_boot chef_run.node['php_fpm']['service']['name']
    expect(chef_run).to start_service chef_run.node['php_fpm']['service']['name']

    service = chef_run.service(chef_run.node['php_fpm']['service']['name'])
    expect(service.pattern).to eq(chef_run.node['php_fpm']['service']['pattern'])
  end
end
