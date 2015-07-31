actions :create, :delete, :upgrade
default_action :upgrade

attribute :name, :kind_of => String, :name_attribute => true
attribute :path, :kind_of => Pathname, :required => true
