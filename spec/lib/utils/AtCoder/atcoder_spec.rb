require 'rails_helper'
require 'yaml'

require 'utils/AtCoder/atcoder'

RSpec.describe AtCoder, type: :lib do
  describe "AtCoderにログイン" do
    context "AtCoderにログインできた場合" do
      before do
        # HACK: ログイン情報の取得に失敗した場合の処理を追加する必要があるのでは?
        credential = YAML.load(File.read("lib/utils/AtCoder/login.yml"))
        @response  = nil

        VCR.use_cassette("atcoder/login") do
          @response = AtCoder::AtCoder.login(credential[:user_name],
                                             credential[:password])
        end
      end

      it "ログインに成功" do
        expect(@response[:login_page].title).to eq "Sign In - AtCoder"
        expect(@response[:top_page].code).to eq "200"
        expect(@response[:top_page].title).to eq "AtCoder"
        expect(AtCoder::AtCoder.logged_in?).to eq true
        expect(@response[:agent].nil?).to eq false
      end

      it "ログアウト" do
        expect(AtCoder::AtCoder.logged_in?).to eq true
        response = AtCoder::AtCoder.logout
        expect(AtCoder::AtCoder.logged_in?).to eq false

        # FIXME: 本来であればサインインのページに戻るべき
        # ログアウトを試みたが、フォームにsubmitや関連ボタンがなく実行が難しい状況
        # そもそもMechanizeでは、JavaScriptのページを操作するのが苦手らしい
        # expect(response.title).to eq "Sign In - AtCoder"
      end
    end
  end
end
