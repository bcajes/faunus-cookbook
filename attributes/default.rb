default[:faunus] = {
  :installation_dir => "/opt/faunus/",
  :version => "0.4.2",  
  :user => "faunus",
  :group => "faunus",
  :install_dir_permissions => "755",
}

default[:faunus][:download_url] = "http://s3.thinkaurelius.com/downloads/faunus/faunus-#{default[:faunus][:version]}.zip"
