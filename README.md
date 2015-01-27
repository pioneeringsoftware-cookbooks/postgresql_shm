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
    <td><tt>['postgresql_shm']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

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
