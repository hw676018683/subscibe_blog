module ExceptionNotifier
  class SlackNotifier

    attr_accessor :notifier

    def initialize(options)
      begin
        webhook_url = options.fetch(:webhook_url)
        @message_opts = options.fetch(:additional_parameters, {})
        @notifier = Slack::Notifier.new webhook_url, options
      rescue
        @notifier = nil
      end
    end

    def call(exception, options={})
      # part 1: 基本信息
      message = [
        "Time: #{Time.zone.now.strftime('%Y-%m-%d %H:%M:%S')}",
        "*Exception*: `#{exception.message}`"
        ].join("\n")

      attachments = []

      # part 2: 错误堆栈
      backtrace_detail = {
        color: "danger",
        title: "Backtrace",
        text: exception.backtrace.join("\n"),
        mrkdwn_in: %w(text fallback)
      }

      attachments << backtrace_detail

      # part 4: request 请求参数
      if options[:env].present?
        begin
          env = options[:env]
          req = Rack::Request.new env

          req_link = req.url
          req_params = env["action_dispatch.request.parameters"].map { |k, v| "* #{k}=#{v}" }.join("\n")

          req_detail = {
            title: req_link,
            color: "#D9EDF7",
            text: req_params,
            mrkdwn_in: %w(text title fallback)
          }

          attachments << req_detail
        rescue => err
        end
      end

      # 加上超时，2秒钟
      begin
        Timeout.timeout(2) do
          @notifier.ping message, attachments: attachments if valid?
        end
      rescue => err
      end

    end

    protected

    def valid?
      !@notifier.nil?
    end
  end
end