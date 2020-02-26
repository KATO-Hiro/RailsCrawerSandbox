# require 'logger'

require 'utils/AtCoder/api_request'
require 'utils/AtCoder/request'
require 'utils/AtCoder/api_client'
require 'utils/AtCoder/client'
require 'utils/AtCoderProblems/api_request'
require 'utils/AtCoderProblems/request'
require 'utils/AtCoderProblems/api_client'
require 'utils/AtCoderProblems/client'

module Crawler
  # FIXME: ログを取れるようにする
  # 手順  : Railsガイドにしたがって設定した
  # エラー: debug、infoなどのメソッドが存在しない
  # @logger = Logger.new(STDOUT)
  # @logger = Logger.new('log/crawler.log')

  # Usage:
  # require 'crawler'
  # results = Crawler::AtCoderProblemsAPI.fetch_contests
  class AtCoderProblemsAPI
    def self.fetch_contests
      # @logger.info("DEBUG: Start fetch_contests")

      request   = AtCoderProblems::Request::ContestsRequest.build
      responses = AtCoderProblems::Client::ContestsClient.send(request)

      # FIXME: Contest.upsert_all(responses)を使ってスマートに実装する
      # エラー: Mysql2::Error: Field 'created_at' doesn't have a default value
      # created_atを生成する方法が分からないため、愚直な方法で実装している
      responses.each do |response|
        next if Contest.find_by(name: response[:name])

        # FIXME: もっとスマートな実装方法があるはず
        if response.save
        else
          @logger.info("DEBUG: Failed to save the contest" + "#{response.inspect}")
        end
      end

      # @logger.info("DEBUG: End fetch_contests")
    end
  end

  # Usage:
  # require 'crawler'
  # Crawler::AtCoderAPI.unified_contest_standings "abc154"
  # Crawler::AtCoderAPI.fetch_contest_standings "abc154"
  # Crawler::AtCoderAPI.fetch_virtual_contest_standings "abc154"
  class AtCoderAPI
    def self.unified_contest_standings(contest_id)
      self.fetch_contest_standings contest_id
      self.fetch_virtual_contest_standings contest_id
    end

    # コンテスト本番の順位表をAtCoderのAPI経由で取得
    def self.fetch_contest_standings(contest_id)
      Rails.logger.info("INFO: Start fetch_contest_standings")

      request   = AtCoder::Request::StandingsRequest.build(contest_id)
      responses = AtCoder::Client::StandingsClient.send(request)

      Rails.logger.info("INFO: End fetch_contest_standings")

      {
        request:   request,
        responses: responses
      }
    end

    # バーチャルコンテストの順位表をAtCoderのAPI経由で取得
    def self.fetch_virtual_contest_standings(contest_id)
      Rails.logger.info("INFO: Start fetch_virtual_contest_standings")

      request   = AtCoder::Request::VirtualStandingsRequest.build(contest_id)
      responses = AtCoder::Client::StandingsClient.send(request)

      Rails.logger.info("INFO: End fetch_virtual_contest_standings")

      {
        request:   request,
        responses: responses
      }
    end
  end
end