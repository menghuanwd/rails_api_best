# frozen_string_literal: true

module Wechat
  def self.redis
    redis_params = {
      host: Settings.redis.host,
      password: Settings.redis.password,
      port: Settings.redis.port,
      db: Settings.redis.queue
    }

    @redis ||= Redis::Namespace.new(
      Settings.redis.namespace,
      redis: Redis.new(redis_params)
    )
  end

  module Token
    class AccessTokenBase
      def read_token
        JSON.parse(Wechat.redis.get(redis_key)) || {}
      end

      def write_token(token_hash)
        Wechat.redis.set redis_key, token_hash.to_json
      end

      private

      def redis_key
        "my_app_wechat_token_#{secret}"
      end
    end
  end

  module Ticket
    class JsapiBase
      def read_ticket
        JSON.parse(Wechat.redis.get(redis_key)) || {}
      end

      def write_ticket(ticket_hash)
        Wechat.redis.set redis_key, ticket_hash.to_json
      end

      private

      def redis_key
        "my_app_wechat_ticket_#{access_token.secret}"
      end
    end
  end
end
