module LinksHelper
  def represent_link(protocol, host, path_key)
    protocol + host + '/' + path_key
  end
end
