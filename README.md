# conda cookbook

This cookbook installs conda via the [miniconda installer](https://conda.io/miniconda.html) and lets you set up / update environments.


## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['conda']['path']</tt></td>
    <td>/path/to/where/you/want</td>
    <td>install directory for all conda files</td>
    <td><tt>/opt/conda</tt></td>
  </tr>
</table>

## Usage

### conda::default

Include `conda` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[conda::default]"
  ]
}
```

This will install conda to the specified path.

### conda\_environment resource
To install environments, you can use the `conda_environment` resource in
another recipe: 
```ruby
conda_environment "new_env" do
  path Pathname.new("/root/environment.yml")
  action :create
end
```
`path` attribute points to the location of the `environment.yml` file.
Actions are one of:

- `:create` (for a new environment)
- `:upgrade` (for environments that already exist)
-  `:delete` (to delete an environment)
