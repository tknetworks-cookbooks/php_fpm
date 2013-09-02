site :opscode

metadata

cookbook "debian", git: "git://github.com/tknetworks-cookbooks/debian.git"

group :integration do
  cookbook 'apt'
  cookbook 'minitest-handler'
  cookbook 'php_fpm_test', :path => './test/cookbooks/php_fpm_test'
end
