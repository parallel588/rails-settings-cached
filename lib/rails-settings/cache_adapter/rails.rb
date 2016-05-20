module RailsSettings
  module CacheAdapter
    class Rails
      def write(key, value)
        Rails.cache.write(key, value)
      end

      def delete(key)
        Rails.cache.delete(key)
      end

      def fetch(name, options = {}, &block)
        Rails.cache.fetch(name, options, &block)
      end
    end
  end
end
