apt_repository 'emdebian' do
  # key_package 'emdebian-archive-keyring'
  uri 'http://www.emdebian.org/debian'
  components ['main']
  distribution 'unstable'
  action :add
  deb_src false
  arch 'amd64'
end

%w{build-essential gcc-arm-linux-gnueabihf debootstrap u-boot-tools device-tree-compiler binutils-arm-linux-gnueabi libncurses5-dev fakeroot zlib1g-dev libncurses5-dev curl git unzip emacs23-nox wget}.each do | pkg | 
  package pkg
end

git 'linux-pcduino' do
  action :sync
  repository  "https://github.com/pcduino/kernel.git"
  reference   "master"
  destination "/home/kitchen/linux-pcduino"
  enable_submodules true
  timeout 1800
end

# git 'linux-sunxi' do
#   action :sync
#   repository  "https://github.com/linux-sunxi/linux-sunxi.git"
#   reference   "sunxi-3.4"
#   destination "/home/kitchen/linux-sunxi"
#   timeout 1800
# end

# execute 'get archive' do
#   command 'wget -q "https://github.com/linux-sunxi/linux-sunxi/archive/sunxi-3.4.zip" -O ~/sunxi-3.4.zip'
#   not_if ::File.exist?('~/sunxi-3.4.zip')
# end

# execute 'unzip archive' do
#   command 'unzip -q ~/sunxi-3.4.zip -d ~'
#   not_if { ::File.directory?('/home/kitchen/linux-sunxi-sunxi-3.4') }
# end

# execute 'move to sunxi' do
#   command 'mv ~/linux-sunxi-sunxi-3.4 ~/linux-sunxi'
#   not_if { ::File.directory?('/home/kitchen/linux-sunxi') }
# end

execute 'get config' do
  command 'wget "https://raymii.org/s/inc/downloads/olinux/a10/kernel_config_raymii" -O ~/linux-sunxi/.config'
  not_if { ::File.exist?('~/linux-sunxi/.config') }
end

include_recipe 'starbrain::compile'
