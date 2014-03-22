#http://s3.thinkaurelius.com/downloads/faunus/faunus-version<>.zip
# 1. Download the Zip to /tmp
require "tmpdir"

#create faunus user and group
group node[:faunus][:group] do
  action :create
end
user node[:faunus][:user] do
  gid node[:faunus][:group]
  home node[:faunus][:installation_dir]
end

td          = Dir.tmpdir
tmp         = File.join(td, "faunus-#{node.faunus.version}.zip")
zip_dir = File.join(td, "faunus-#{node.faunus.version}")

remote_file(tmp) do
  source node.faunus.download_url
  action :create_if_missing
  owner node["faunus"]["user"]
  group node["faunus"]["group"]
end

directory "#{node.faunus.installation_dir}" do
  owner node["faunus"]["user"]
  group node["faunus"]["group"]
  mode node["faunus"]["install_dir_permissions"]
  recursive true
end

# 2. Extract it
# 3. Copy to faunus home, update permissions
package "unzip"
bash "extract #{tmp}, move it to #{node.faunus.installation_dir}" do
  user node.faunus.user
  cwd  "/tmp"

  code <<-EOS
    rm -rf #{node.faunus.installation_dir}
    unzip #{tmp}
    mv --force #{zip_dir} #{node.faunus.installation_dir}
  EOS
  
  creates "#{node.faunus.installation_dir}/bin/gremlin.sh"
end



#xxx choose location for funaus graph properties
