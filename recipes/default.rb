#-------------------------------------------------------------------------------
#
# Cookbook Name:: postgresql_shm
#        Recipe:: default
#
#-------------------------------------------------------------------------------
#
# Copyright (c) 2015, Pioneering Software, United Kingdom. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy of
# the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either expressed or implied. See the
# License for the specific language governing permissions and limitations under
# the License.
#
#-------------------------------------------------------------------------------

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
