execute 'configure board' do
  command './configure pcduino'
  cwd "#{Chef::Config[:file_cache_path]}/linux-pcduino"
  notifies :create, 'template[create choosen_board.mk]' 
end

template 'create choosen_board.mk' do
  source 'choosen_board.mk.erb'
  path "#{Chef::Config[:file_cache_path]}/linux-pcduino/chosen_board.mk"
  notifies :run, 'execute[crosscompile sunxi kernel]', :immediately
end

execute 'crosscompile sunxi kernel' do
  command 'make'
  cwd "#{Chef::Config[:file_cache_path]}/linux-pcduino"
  timeout 3600
  action :nothing
end

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
# execute 'Compile RTL hostapd' do
#   command 'make install'
#   cwd '/home/kitchen/RTL8188-hostapd/hostapd'
#   only_if { node['starbrain']['hotspot'] }
# end
