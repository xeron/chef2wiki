class Chef2Wiki

  # Get data for node.
  #
  # ==== Attributes
  # * +node_name+ - Name of the node from chef (String)
  # ==== Returns
  # * Node data (Hash)
  def node_data(node_name)
    node = Chef::Node.load(node_name)
    data = node.to_hash
    data["run_list"] = node.run_list.run_list_items
    return data
  end

  # Get node list.
  #
  # ==== Returns
  # * Node list (Array)
  def node_list
    Chef::Node.list.keys
  end

  # Get excluded node list.
  #
  # ==== Returns
  # * Node list (Array)
  def excluded_node_list
    config["nodes"] ? config["nodes"]["exclude"] : []
  end

end
