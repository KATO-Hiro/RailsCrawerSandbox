module AtCoder
  # See:
  # https://qiita.com/arabian9ts/items/e8babf72d7225364b8f4
  # https://github.com/sackey24/AtCoderRivals/blob/master/lib/crawler.rb
  class APIClient
    class << self
      def send(request)
        responses = fetch_api_in_json_format request[:url]
        # format(responses)
      end

      private
        def fetch_api_in_json_format(url)
          require 'mechanize'
          require 'json'
          require 'yaml'

          require 'utils/AtCoder/atcoder'

          Rails.logger.info("INFO: Start fetch_api_in_json_format")
          sleep 1
          # sleep 10

          begin
            credential = YAML.load(File.read("lib/utils/AtCoder/login.yml"))
            response   = AtCoder.login(credential[:user_name],
                                       credential[:password])
            standings  = nil

            if AtCoder.logged_in?
              Rails.logger.info("INFO: #{url}")

              standings_api = response[:agent].get(url)
              standings = JSON.parse standings_api.body
            else
              Rails.logger.error("ERROR: Login to AtCoder failed")
            end

          rescue IOError => e
            Rails.logger.error("ERROR: #{e.message}")
          rescue TimeoutError => e
            Rails.logger.error("ERROR: #{e.message}")
          rescue Mechanize::ResponseReadError => e
            Rails.logger.error("ERROR: #{e.force_parse}")
            Rails.logger.error("ERROR: #{e.message}")
          rescue JSON::ParserError => e
            Rails.logger.error("ERROR: #{e.message}")
          rescue => e
            Rails.logger.error("ERROR: #{e.message}")
          end

          Rails.logger.info("INFO: End fetch_api_in_json_format")
          standings
        end

        def format(responses)
          raise NotImplementedError
        end
    end
  end
end
