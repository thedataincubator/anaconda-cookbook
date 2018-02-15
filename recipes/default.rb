remote_file "#{Chef::Config[:file_cache_path]}/Miniconda.sh" do
  source "https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh"
  mode "777"
  checksum "df2f9770d83df8269f3f43f1e60285e6"
end

file "/etc/profile.d/conda.sh" do
  content "export PATH=/opt/conda/bin:$PATH"
  mode "755"
end

bash "install_miniconda" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
      /bin/bash Miniconda.sh -b -p #{node["conda"]["path"]}
  EOH
  not_if do ::File.exists? "/opt/conda" end
end
