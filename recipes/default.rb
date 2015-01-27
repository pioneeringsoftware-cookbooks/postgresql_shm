#
# Cookbook Name:: postgresql_shm
# Recipe:: default
#
# Copyright (C) 2015 Roy Ratcliffe
#
# All rights reserved - Do Not Redistribute
#

# See http://www.postgresql.org/message-id/attachment/2697/shmsetup
page_size, _phys_pages = %w(PAGE_SIZE _PHYS_PAGES).map do |var|
  `getconf #{var}`.chomp.to_i
end

shmall = (_phys_pages * node['postgresql']['shm']['all'].to_f).floor
shmmax = shmall * page_size
shared_buffers = (shmmax * node['postgresql']['shm']['buffers'].to_f).to_i

node.default['sysctl']['params']['kernel']['shmall'] = shmall
node.default['sysctl']['params']['kernel']['shmmax'] = shmmax

node.default['postgresql']['config']['shared_buffers'] = "#{shared_buffers >> 10}kB"
