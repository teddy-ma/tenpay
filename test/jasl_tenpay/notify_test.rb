require 'test_helper'

class JaslTenpay::NotifyTest < Test::Unit::TestCase
  SUCCESS_RETURN = <<-XML
    <?xml version="1.0" encoding="GBK"?>
    <root>
      <input_charset>UTF-8</input_charset>
      <partner>2000054321</partner>
      <retcode>0</retcode>
      <retmsg />
      <sign>1C58B3A778D9F49F3FA91D30E9A831D2</sign>
      <sign_key_index>1</sign_key_index>
      <sign_type>MD5</sign_type>
    </root>
  XML

  FAIL_RETURN = <<-XML
    <?xml version="1.0" encoding="GBK"?>
    <root>
      <input_charset>UTF-8</input_charset>
      <partner>2000054321</partner>
      <retcode>88222005</retcode>
      <retmsg />
      <sign>1C58B3A778D9F49F3FA91D30E9A831D2</sign>
      <sign_key_index>1</sign_key_index>
      <sign_type>MD5</sign_type>
    </root>
  XML

  def setup
    @options = {
      :notify_id => '123456789012345678901234567890',
      :sign => '9E3178005EF2DFF87348E00889765FF0'
    }
    @url = "https://gw.tenpay.com/gateway/simpleverifynotifyid.xml?input_charset=UTF-8&partner=1900000113&notify_id=123456789012345678901234567890&sign=E040AFBCBC409EA0C62CF0F11CF0BAA4"
  end

  def test_verify_notify_when_success
    FakeWeb.register_uri(:get, @url, :body => SUCCESS_RETURN)
    assert JaslTenpay::Notify.verify?(@options, '1900000113', 'e82573dc7e6136ba414f2e2affbe39fa')
  end

  def test_verify_notify_when_fail
    FakeWeb.register_uri(:get, @url, :body => FAIL_RETURN)
    assert !JaslTenpay::Notify.verify?(@options, '1900000113', 'e82573dc7e6136ba414f2e2affbe39fa')
  end
end
