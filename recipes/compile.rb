# execute 'crosscompile sunxi kernel' do
#   command 'make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- uImage modules'
#   cwd '/home/kitchen/linux-sunxi'
#   timeout 3600
# end

# execute 'making modules tree' do
#   command 'make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install'
#   cwd '/home/kitchen/linux-sunxi'
#   timeout 3600
# end

# execute 'making modules tree' do
#   command 'make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- INSTALL_MOD_PATH=output modules_install'
#   cwd '/home/kitchen/linux-sunxi'
#   timeout 3600
# end

# log 'Your uImage location is /home/kitchen/linux-sunxi/arch/arm/boot/uImage' do
#   message 'Your uImage location is /home/kitchen/linux-sunxi/arch/arm/boot/uImage'
# end

# log 'Your modules location is /home/kitchen/linux-sunxi/output/lib/modules/3.4.XXX' do
#   message 'Your modules location is /home/kitchen/linux-sunxi/output/lib/modules/3.4.XXX'
# end

# execute 'Compress sunxi kernel' do
#   command 'tar -czpf sunxi_kernel.tar.gz /home/kitchen/linux-sunxi/arch/arm/boot/uImage /home/kitchen/linux-sunxi/output/lib/modules/3.4*'
#   cwd '/home/kitchen/'
# end


## compiling wifi driver

execute 'Getting proprietary wifi driver' do
  command 'wget "http://12244.wpc.azureedge.net/8012244/drivers/rtdrivers/cn/wlan/0001-RTL8188C_8192C_USB_linux_v4.0.2_9000.20130911.zip" -O 0001-RTL819xSU_usb_linux_v2.6.6.0.20120405.zip'
  cwd '/home/kitchen'
end

execute 'Unzip proprietary wifi driver' do
  command 'unzip 0001-RTL819xSU_usb_linux_v2.6.6.0.20120405.zip'
  cwd '/home/kitchen'
end

git 'RTL hostapd' do
  repository 'https://github.com/jenssegers/RTL8188-hostapd'
  action :sync
  destination '/home/kitchen/RTL8188-hostapd'
end

# execute 'Compile RTL hostapd' do
#   command 'make install'
#   cwd '/home/kitchen/RTL8188-hostapd/hostapd'
# end
