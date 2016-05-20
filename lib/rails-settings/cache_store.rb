module RailsSettings

  class CacheStore
    class << self
      def write(key, value)
        cache_adapter.write(key, value)
      end

      def delete(key)
        cache_adapter.delete(key)
      end

      def fetch(name, options = {}, &block)
        cache_adapter.fetch(name, options, &block)
      end

      def cache_adapter
        @cache_adapter ||
          begin
            @cache_adapter = case RailsSettings.configuration.cache_adapter
            when :redis
              RailsSettings::CacheAdapter::Redis.new(
                RailsSettings.configuration.redis_client
              )
            else
              RailsSettings::CacheAdapter::Rails.new
            end
          end

        @cache_adapter
      end
    end
  end

end
