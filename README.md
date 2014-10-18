# chef2wiki

Generates wiki documentation from Chef node attributes using ERB templates.

## Quick start:

On the first launch chef2wiki creates default config and templates files at `~/.chef2wiki`.

### Configure wiki parameters:
`~/.chef2wiki/config.yml` example:

```
wiki:
  api_url: "http://my.wiki.org/api.php"
  login: Admin
  password: Password
  # domain: my_ldap

chef:
  config: ~/.chef/knife.rb

cookbooks:
  repo_paths:
    - "~/chef/cookbooks/repo/cookbooks"
    - "~/chef/cookbooks/repo/site-cookbooks"

nodes:
  exclude: ["old_node.example.com", "node2.example.com"]
```

- change wiki api url to yours
- change login and password if you need it (or just remove if not)
- provide a path to knife/chef config
- provide a path(s) to cookbooks if you want README.md files being posted to wiki as well
- you can exclude nodes from being processed
- execute chef2wiki

LDAP domain support requires http://www.mediawiki.org/wiki/Extension:LDAP_Authentication

## Templates system

Templates are located at `~/.chef2wiki/templates`. Required templates are:

| Template | Wiki page | Variables |
| -------- | --------- | --------- |
| `node.erb` – main node template | As node name | `@data` – node attributes (Hash) |
| `nodes.erb` – nodes list | `Servers_list` | `@node_list` – list of nodes (Array of Strings) |
| `documentation.erb` – template for README.md | As cookbook name | `@content` – content of README.md |
| `documentation_list.erb` | `Cookbooks_documentation` | `@cookbooks` – list of cookbooks (Array) |

You can use partials. For example default `node.erb` calls `node/common.erb`: `<%= render 'node/common.erb' %>`

## Contributing to chef2wiki

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 Ivan Larionov. See LICENSE for further details.
