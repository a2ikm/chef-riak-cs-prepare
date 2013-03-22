riak-cs-prepare Cookbook
====================
Pre-Configures riak and riak-cs

This cookbook aligns with riak and riak-cs cookbooks.

Requirements
------------
This cookbook depends riak and riak-cs cookbooks.

- riak: https://github.com/basho/riak-chef-cookbook
- riak-cs: https://github.com/basho/riak-cs-chef-cookbook


Attributes
----------
None.

Usage
-----
Just include `riak-cs-prepare` in your run_list.
Please put it before riak and riak-cs.


```json
{
  "name":"my_node",
  "run_list": [
    "recipe[riak-cs-prepare]",
    "recipe[riak]",
    "recipe[riak-cs]",
    "recipe[riak-cs::stanchion]"
  ]
}
```

Contributing
------------
e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Takeshi KOMIYA
