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

describe 'php_fpm::www' do
  include_context 'debian'

  let (:chef_run) {
    ChefSpec::ChefRunner.new(:step_into => %w{php_fpm_pool}, :log_level => :debug) do |node|
      set_node(node)
    end
  }

  it 'should configure [www] pool' do
    chef_run.converge('php_fpm::www')
    conf = chef_run.template("#{chef_run.node['php_fpm']['conf_dir']}/pool.d/www.conf")
    expect(conf.variables).to eq(
      :user => 'www-data',
      :group => 'www-data',
      :name => 'www',
      :variables => {}
    )
  end
end
