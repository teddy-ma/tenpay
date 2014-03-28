require 'digest/md5'

module JaslTenpay
  module Sign
    def self.generate(params, jkey)
      query = params.sort.map do |key, value|
        "#{key}=#{value}"
      end.join('&')

      Digest::MD5.hexdigest("#{query}&key=#{jkey}").upcase
    end

    def self.verify?(params, pid, jkey)
      params = Utils.stringify_keys(params)
      sign = params.delete('sign')

      generate(params, jkey) == sign
    end
  end
end
