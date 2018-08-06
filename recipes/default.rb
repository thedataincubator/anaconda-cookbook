remote_file "#{Chef::Config[:file_cache_path]}/Miniconda.sh" do
  source "https://repo.continuum.io/miniconda/Miniconda2-4.5.4-Linux-x86_64.sh"
  mode "777"
  checksum "77d95c99996495b9e44db3c3b7d7981143d32d5e9a58709c51d35bf695fda67d"
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
