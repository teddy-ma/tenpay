module JaslTenpay
  module Notify
    GATEWAY = 'https://gw.tenpay.com/gateway/simpleverifynotifyid.xml'
    SUCCESS_STR = '<retcode>0</retcode>'

    def self.verify?(params, pid, jkey)
      return false unless Sign.verify?(params, pid, jkey)

      params = {
          'input_charset' => 'UTF-8',
          'partner' => pid,
          'notify_id' => CGI.escape(params[:notify_id].to_s)
      }

      open("#{GATEWAY}?#{Utils.make_query_string(params, jkey)}").read.include?(SUCCESS_STR)
    end
  end
end
