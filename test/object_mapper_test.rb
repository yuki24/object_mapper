require 'test_helper'

require 'json'
require 'fixtures/plain_old_ruby_objects'

class ObjectMapperTest < Minitest::Test
  MAPPING = {
    ProductCollection => { _links: Links, products: Array(Product) },
    Product           => { _links: Links },
    Links             => { self: Link }
  }

  def setup
    json  = open('./test/fixtures/list_of_products.json').read
    @hash = JSON.parse(json, symbolize_names: true)
  end

  def test_object_mapepr_with_a_complete_mapping
    collection = ObjectMapper
                 .new(MAPPING)
                 .convert(@hash, to: ProductCollection)

    assert_equal 1,         collection.products[0].id
    assert_equal "Ruby",    collection.products[0].name
    assert_equal "Elegant", collection.products[0].feature_list[0]

    assert_equal "https://www.ruby-lang.org/",          collection._links.self.href
    assert_equal "https://www.ruby-lang.org/en/about/", collection.products[0]._links.self.href
  end

  def test_object_mapepr_with_an_empty_mapping_but_with_a_class_argument
    collection = ObjectMapper
                 .new({})
                 .convert(@hash, to: ProductCollection)

    assert_equal 1,         collection.products[0][:id]
    assert_equal "Ruby",    collection.products[0][:name]
    assert_equal "Elegant", collection.products[0][:feature_list][0]

    assert_equal "https://www.ruby-lang.org/",          collection._links[:self][:href]
    assert_equal "https://www.ruby-lang.org/en/about/", collection.products[0][:_links][:self][:href]
  end

  def test_object_mapepr_with_an_empty_mapping_without_arguments
    collection = ObjectMapper
                 .new({})
                 .convert(@hash)

    assert_equal 1,         collection[:products][0][:id]
    assert_equal "Ruby",    collection[:products][0][:name]
    assert_equal "Elegant", collection[:products][0][:feature_list][0]

    assert_equal "https://www.ruby-lang.org/",          collection[:_links][:self][:href]
    assert_equal "https://www.ruby-lang.org/en/about/", collection[:products][0][:_links][:self][:href]
  end

  def test_argument_error_message_includs_class_name
    error = assert_raises(ArgumentError) do
      ObjectMapper.new({}).convert(@hash, to: Product)
    end

    assert_equal "unknown keyword: products (class: `Product')", error.message
    assert_match(/test\/fixtures\/plain_old_ruby_objects\.rb/, error.backtrace.first)
  end
end
