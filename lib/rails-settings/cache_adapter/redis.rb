module RailsSettings
  module CacheAdapter
    class Redis
      attr_reader :client

      def initialize(client)
        @client = client
      end

      def write(key, value)
        client.set(key, Marshal.dump(value))
      end

      def delete(key)
        client.del(key)
      end

      def fetch(key, _ = {})
        if block_given?
          res = client.get(key)
          if res.nil?
            res = yield
            client.set(key, Marshal.dump(res))
          else
            res = Marshal.load(res)
          end
          res
        else
          Marshal.load(client.get(key).to_s)
        end
      end
    end
  end
end
