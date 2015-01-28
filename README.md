# postgresql_shm-cookbook

This cookbook sets up shared memory for PostgreSQL servers.

Note, the cookbook does _not_ include recipes for installing PostgreSQL. You
still need to apply the `postgresql` cookbook. The recipe only provides
attribute defaults for the `postgresql` and `sysctl` cookbooks even though it
does not automatically include these.

Specifically the cookbook sets up kernel shared-memory settings `SHMALL` and
`SHMMAX` as well as the `shared_buffers` setting for PostgreSQL.

`SHMALL` defines the total amount of shared memory pages available for use
system-wide. The default recipe determines the amount of shared memory
accessible from the kernel based on the number of physical memory pages and the
size of those pages. By default, it selects 40% of the available physical
memory allocated for shared memory and directs PostgreSQL to consume up to 95%
of that space. You can adjust both these ratios.

## Supported Platforms

The cookbook supports all known platforms. Its only dependency, apart from Chef
itself, is the `getconf` command line utility which the default recipe uses to
access the system's page size and number of physical pages. On Linux systems,
this binary typically comes as standard with the GNU C library.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['postgresql']['shm']['all']</tt></td>
    <td>Float</td>
    <td>Defines what ratio of available physical memory should be available for shared memory</td>
    <td><tt>0.4</tt></td>
  </tr>
  <tr>
    <td><tt>['postgresql']['shm']['buffers']</tt></td>
    <td>Float</td>
    <td>Defines what ratio of available shared memory should be used for PostgreSQL shared buffers</td>
    <td><tt>0.95</tt></td>
  </tr>
</table>

## Usage

This is how you might typically apply this cookbook: by combining it with other
relevant cookbook recipes to set up a PostgreSQL server in a _role_. See below.

Notice the ordering of recipes. This cookbook's default recipe runs first, then
`sysctl`'s `apply` recipe applies the new defaults. Notice also the additional
`synchronous_commit` and `db_type` attributes for performance enhancements to
the database server. See the [`postgresql`][postgresql] cookbook at Opscode for
more details.

[postgresql]:https://supermarket.chef.io/cookbooks/postgresql

```json
{
  "name": "postgresql",
  "description": "",
  "json_class": "Chef::Role",
  "default_attributes": {
    "postgresql": {
      "config": {
        "synchronous_commit": false
      },
      "config_pgtune": {
        "db_type": "web"
      }
    }
  },
  "override_attributes": {
  },
  "chef_type": "role",
  "run_list": [
    "recipe[sysctl::apply]",
    "recipe[postgresql::server]",
    "recipe[postgresql::contrib]",
    "recipe[postgresql::config_pgtune]",
    "recipe[postgresql_shm]"
  ],
  "env_run_lists": {
  }
}
```

### postgresql_shm::default

Include `postgresql_shm` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[postgresql_shm::default]"
  ]
}
```

## License and Authors

Author:: Roy Ratcliffe (<roy@pioneeringsoftware.co.uk>)
