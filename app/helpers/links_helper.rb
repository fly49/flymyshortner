module LinksHelper
  def represent_link(link)
    request.host + '/' + link.path_key
  end
end
