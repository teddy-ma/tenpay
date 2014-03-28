require 'test_helper'

class JaslTenpay::SignTest < Test::Unit::TestCase
  def setup
    @params = {
      :service => 'test',
      :partner => '123'
    }
    @sign = Digest::MD5.hexdigest("partner=123&service=test&key=e82573dc7e6136ba414f2e2affbe39fa").upcase
  end

  def test_generate_sign
    assert_equal @sign, JaslTenpay::Sign.generate(@params, 'e82573dc7e6136ba414f2e2affbe39fa')
  end

  def test_verify_sign
    assert JaslTenpay::Sign.verify?(@params.merge(:sign => @sign), '1900000113', 'e82573dc7e6136ba414f2e2affbe39fa')
  end

  def test_verify_sign_when_fails
    assert !JaslTenpay::Sign.verify?(@params.merge(:danger => 'danger', :sign => @sign), '1900000113', 'e82573dc7e6136ba414f2e2affbe39fa')
  end
end
