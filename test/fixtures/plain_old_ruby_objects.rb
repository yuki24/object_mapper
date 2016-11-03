class ProductCollection
  attr_reader :products, :_links
  def initialize(products: nil, _links: nil)
    @products, @_links = products, _links
  end
end

class Product
  attr_reader :id, :name, :homepage, :feature_list, :_links
  def initialize(id: nil, name: nil, homepage: nil, _links: nil, feature_list: nil)
    @id, @name, @homepage, @_links, @feature_list = id, name, homepage, _links, feature_list
  end
end

class Links
  attr_reader :self
  def initialize(self: nil)
    @self = binding.local_variable_get(:self)
  end
end

class Link
  attr_reader :href
  def initialize(href: nil)
    @href = href
  end
end
