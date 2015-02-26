require "active_support/cache"
require "active_support/logger"

module JSONSerializer
  module InstanceMethods
    def as_json(options={})
      if json_collection?
        process_collection
      else
        process_object
      end
    end

    def json_type
      @json_type ||= :object
    end

    private

    def process_collection
      if cache_enabled?
        log_cache_hit
        fetch_cache { collection.map(&:as_json) }
      else
        collection.map(&:as_json)
      end
    end

    def process_object
      if cache_enabled?
        log_cache_hit
        fetch_cache { generate_json }
      else
        generate_json
      end
    end

    def log_cache_hit
      if cache.exist? expand_cache_key
        logger.info "Read fragment from cache #{expand_cache_key}"
      else
        logger.info "Write fragment to cache #{expand_cache_key}"
      end
    end

    def generate_json
      json = {}
      attributes.each do |attribute|
        json[attribute] = self.send(attribute)
      end
      json
    end

    def fetch_cache(&block)
      cache.fetch(expand_cache_key, expires_in: 1.day, &block)
    end

    def cache_enabled?
      defined? cache_key
    end

    def expand_cache_key
      @expand_cache_key ||= ::ActiveSupport::Cache.
        expand_cache_key([self.class.to_s.underscore, cache_key, 'JSON'])
    end

    def cache
      ::ActiveSupport::Cache::Store.new
    end

    def logger
      ::ActiveSupport::Logger.new(STDOUT)
    end

    def json_collection?
      json_type == :collection
    end
  end
end
