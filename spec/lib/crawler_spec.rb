require 'rails_helper'
require 'crawler'

RSpec.describe Crawler, type: :lib do
  describe "AtCoder本家からコンテスト本番の順位表を取得(.json)" do
    before do
      results = Crawler::AtCoderAPI.fetch_contest_standings "abc155"
      @request = results[:request]
      # レスポンスを受け取る
      # vcrを使って、jsonファイルを保存する(APIを複数回叩かないようにするため)
    end

    context "正常系: 順位表が取得できた場合" do
      it "コンテストの略称を返す" do
        contest_id = "abc155"
        expect(@request[:contest_id]).to eq contest_id
      end

      it "コンテストのURLを返す" do
        contest_url = "https://atcoder.jp/contests/abc155/standings/json"
        expect(@request[:url]).to eq contest_url
      end

      it "コンテスタントの属性を返す"
      it "コンテスト結果を返す"
    end

    context "異常系: 順位表が取得できなかった場合" do
      it "HTTP: リダイレクトが発生"
      it "HTTP: 成功・リダイレクト以外の状態"

      it "IOErrorが発生"
      it "TimeoutErrorが発生"
      it "JSONのパースに失敗"
      it "その他のエラー"
    end
  end

  describe "AtCoder本家からバーチャルコンテストの順位表を取得(.json)" do
    before do
      results = Crawler::AtCoderAPI.fetch_virtual_contest_standings "abc155"
      @request = results[:request]
      # レスポンスを受け取る
      # vcrを使って、jsonファイルを保存する(APIを複数回叩かないようにするため)
    end

    context "正常系: 順位表が取得できた場合" do
      it "コンテストの略称を返す" do
        contest_id = "abc155"
        expect(@request[:contest_id]).to eq contest_id
      end

      it "コンテストのURLを返す" do
        contest_url = "https://atcoder.jp/contests/abc155/standings/virtual/json"
        expect(@request[:url]).to eq contest_url
      end

      it "コンテスタントの属性を返す"
      it "コンテスト結果を返す"
    end

    context "異常系: 順位表が取得できなかった場合" do
      it "HTTP: リダイレクトが発生"
      it "HTTP: 成功・リダイレクト以外の状態"

      it "IOErrorが発生"
      it "TimeoutErrorが発生"
      it "JSONのパースに失敗"
      it "その他のエラー"
    end
  end
end
