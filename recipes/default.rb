remote_file "#{Chef::Config[:file_cache_path]}/Miniconda.sh" do
    source "https://repo.continuum.io/miniconda/Miniconda-3.10.1-Linux-x86_64.sh"
    mode "777"
    checksum "363f56f5608d1552325549e7371fcf460c5ed45484eb300058e3b99c997808b5"
end

file "/etc/profile.d/conda.sh" do
    content "export PATH=/opt/conda/bin:$PATH"
end

cookbook_file "#{Chef::Config[:file_cache_path]}/environment.yml" do
    source "environment.yml"
end

bash "install_anaconda" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
        /bin/bash Miniconda.sh -b -p /opt/conda
    EOH
    not_if do ::File.exists? "/opt/conda" end
end

# The `conda install numpy` is bug workaround. See
# https://github.com/conda/conda/issues/1420
bash "update_enviroment" do
    cwd Chef::Config[:file_cache_path]
    code <<-EOH
        conda install numpy=1.7
        /opt/conda/bin/conda env update --file=environment.yml --name=root
    EOH
end
