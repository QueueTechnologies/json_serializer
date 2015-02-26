module JSONSerializer
  module ClassMethods
    def json_attributes(*attributes)
      define_method :attributes do
        @attributes ||= attributes
      end
    end

    def json_type(json_type)
      define_method "json_type" do
        @json_type ||= json_type
      end
    end

    def json_cache_keys(*attributes)
      define_method "cache_key" do
        @cache_key ||= Digest::MD5.hexdigest(
          attributes.map { |attribute| self.send(attribute) }.join("-")
        )
      end
    end
  end
end
