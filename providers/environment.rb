def conda
    return "/opt/conda/bin/conda"
end

def exists
    if @new_resource.name == "root"     # root always exists
        return true
    end
    json = JSON.parse(`#{conda} env list --json`)
    env_list = json["envs"]

    return env_list.include?("#/opt/conda/envs/#{@new_resource.name}")
end

action :create do
    if exists
        Chef::Log::info "#{@new_resource} already exists - nothing to create"
    else 
        `#{conda} env create --name #{@new_resource.name} --file #{@new_resource.path}`
    end
end

action :delete do
    if not exists
        Chef::Log::info "#{@new_resource} does not exist - nothing to delete"
    else
        `#{conda} env remove --name #{@new_resource.name} --yes`
    end
end

action :upgrade do
    # Bug workaround for https://github.com/conda/conda/issues/1420
    `#{conda} install --name #{@new_resource.name} toolz=0.6 --yes`
    `#{conda} env update --name #{@new_resource.name} --file #{@new_resource.path}`
end
