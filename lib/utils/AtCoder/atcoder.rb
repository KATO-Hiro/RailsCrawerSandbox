require 'mechanize'

# See:
# https://github.com/sparklemotion/mechanize
# https://rooter.jp/web-crawling/mechanize_beginning/
# https://qiita.com/meguroman/items/6d2520ec83ffa4dfc0c7
module AtCoder
  class AtCoder
    @agent    = nil
    @top_page = nil

    class << self
      def login(user_name, password)
        Rails.logger.info("INFO: Start login")

        @agent = Mechanize.new
        @agent.max_history = 2
        @agent.user_agent_alias = 'Mac Firefox'
        @agent.conditional_requests = false
        atcoder_login_url = 'https://atcoder.jp/login'

        begin
          login_page = @agent.get(atcoder_login_url)

          login_form = login_page.forms[1] # 名称が含まれていなかったため
          login_form.field_with(name: 'username').value = user_name
          login_form.field_with(name: 'password').value = password

          sleep 1
          @top_page = login_form.submit
        rescue Mechanize::ResponseReadError => e
          Rails.logger.error("ERROR: #{e.force_parse}")
        rescue => e
          Rails.logger.error("ERROR: #{e.message}")
        end

        Rails.logger.info("INFO: End login")

        {
          login_page: login_page,
          top_page: @top_page,
          agent: @agent
        }
      end

      def logged_in?
        !@top_page.nil?
      end

      def logout
        Rails.logger.info("INFO: Start logout")
        # Rails.logger.info("INFO: #{@top_page.inspect}")

        # HACK: JavaScriptで動作しており、submitや関連ボタンが存在しない
        # 現状では、Mechanaizeの操作でログアウトができない状況
        logout_form = @top_page.form_with(name: 'form_logout')
        logout_page = logout_form.submit
        # HACK: 暫定的な対処
        @top_page = nil
        Rails.logger.info("INFO: End logout")

        logout_page
      end
    end
  end
end
