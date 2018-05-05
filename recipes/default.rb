remote_file "#{Chef::Config[:file_cache_path]}/Miniconda.sh" do
  source "https://repo.continuum.io/miniconda/Miniconda-3.10.1-Linux-x86_64.sh"
  mode "777"
  checksum "363f56f5608d1552325549e7371fcf460c5ed45484eb300058e3b99c997808b5"
end

file "/etc/profile.d/conda.sh" do
  content "export PATH=/opt/conda/bin:$PATH"
  mode "755"
end

bash "install_miniconda" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
      /bin/bash Miniconda.sh -b -p #{node["conda"]["path"]}
      /opt/conda/bin/conda update -y conda conda-env
  EOH
  not_if do ::File.exists? "/opt/conda" end
end
