module LinksHelper
  def represent_link(path_key)
    request.protocol + request.host + '/' + path_key
  end
end
