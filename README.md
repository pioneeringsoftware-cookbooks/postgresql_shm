# postgresql_shm-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

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
