# Installs an environment called basic_sci that has numpy and jupyter
cookbook_file "/root/environment.yml" do
  source "environment.yml"
  owner "root"
  group "root"
  mode "755"
end

anaconda_environment "root" do
  path "/root/environment.yml"
  action :upgrade
end
