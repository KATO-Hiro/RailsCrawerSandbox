module AtCoderProblems
  # See:
  # https://qiita.com/arabian9ts/items/e8babf72d7225364b8f4
  class APIClient
    class << self
      # FIXME: 引数をハッシュで受け取れるようにする
      def send(url)
        responses = fetch_api_in_json_format url
        format(responses)
      end

      private
        def fetch_api_in_json_format(url)
          require 'json'

          sleep 1

          responses = Faraday.get url
          responses_body = responses.body.force_encoding("UTF-8")
          JSON.parse(responses_body)
        end

        def format(responses)
          raise NotImplementedError
        end
    end
  end
end
