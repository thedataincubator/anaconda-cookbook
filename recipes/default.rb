remote_file "#{Chef::Config[:file_cache_path]}/Miniconda.sh" do
  source "https://repo.continuum.io/miniconda/Miniconda2-4.4.10-Linux-x86_64.sh"
  mode "777"
  checksum "4e4ff02c9256ba22d59a1c1a52c723ca4c4ec28fed3bc3b6da68b9d910fe417c"
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
