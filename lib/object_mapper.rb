require "object_mapper/version"

class ObjectMapper
  def initialize(mapping)
    @mapping = mapping.dup
    @mapping.default = {}
  end

  def convert(result, to: Hash)
    klass = to

    if result.is_a?(Array) && klass != Array
      result.map! {|element| convert(element, to: klass.first) }
    elsif result.is_a?(Hash) && klass != Hash
      result.each do |key, value|
        result[key] = convert(value, to: @mapping[klass][key] || value.class)
      end

      begin
        klass.new(result)
      rescue ArgumentError => e
        raise e, "#{e} (class: `#{klass}')", e.backtrace
      end
    else
      result
    end
  end
end
