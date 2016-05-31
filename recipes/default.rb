apt_repository 'emdebian' do
  # key_package 'emdebian-archive-keyring'
  uri 'http://www.emdebian.org/debian'
  components ['main']
  distribution 'unstable'
  action :add
  deb_src false
  arch 'amd64'
end

%w{build-essential gcc-arm-linux-gnueabihf debootstrap u-boot-tools device-tree-compiler binutils-arm-linux-gnueabi libncurses5-dev fakeroot zlib1g-dev libncurses5-dev curl git unzip emacs23-nox wget libusb-1.0-0-dev pkg-config}.each do | pkg | 
  package pkg
end

git 'linux-pcduino' do
  action :sync
  repository  "https://github.com/pcduino/kernel.git"
  reference   "master"
  destination "#{Chef::Config[:file_cache_path]}/linux-pcduino"
  enable_submodules true
  timeout 1800
end

git 'RTL hostapd' do
  repository 'https://github.com/jenssegers/RTL8188-hostapd'
  action :sync
  destination '#{Chef::Config[:file_cache_path]}/RTL8188-hostapd'
  only_if { node['starbrain']['hotspot'] }
end

# git 'linux-sunxi' do
#   action :sync
#   repository  "https://github.com/linux-sunxi/linux-sunxi.git"
#   reference   "sunxi-3.4"
#   destination "/home/kitchen/linux-sunxi"
#   timeout 1800
# end

remote_file 'get config' do
  source 'https://raymii.org/s/inc/downloads/olinux/a10/kernel_config_raymii'
  path "#{Chef::Config[:file_cache_path]}/linux-pcduino/patch/linux-sunxi/arch/arm/configs/#{node['starbrain']['config_choosen_board']}"
  use_conditional_get true
  use_etag true
end

remote_file 'Getting proprietary wifi driver' do
  source 'http://12244.wpc.azureedge.net/8012244/drivers/rtdrivers/cn/wlan/0001-RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911.zip'
  path "#{Chef::Config[:file_cache_path]}/0001-RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911.zip"
  only_if { node['starbrain']['hotspot'] }
end

# execute 'Getting proprietary wifi driver' do
#   command 'wget "http://12244.wpc.azureedge.net/8012244/drivers/rtdrivers/cn/wlan/0001-RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911.zip" -O 0001-RTL819xSU_usb_linux_v2.6.6.0.20120405.zip'
#   cwd '/home/kitchen'
#   only_if { node['starbrain']['hotspot'] }
# end

execute 'Unzip proprietary wifi driver' do
  command 'unzip -q 0001-RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911.zip'
  not_if { ::File.directory?("#{Chef::Config[:file_cache_path]}/RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911") }
  only_if { node['starbrain']['hotspot'] }
  cwd '/home/kitchen'
end


if node['starbrain']['compile']
  include_recipe 'starbrain::compile'
end
