# Jasl_Tenpay

A simple Tenpay ruby gem, without unnecessary magic or wraper, it's directly facing how Tenpay api works.
copied from [alipay](https://github.com/chloerei/alipay) .

It contain this API:

* Generate payment url
* Verify notify

Please read Tenpay official document first: <http://help.tenpay.com/mch/> .

## Why Jasl_Tenpay?

Cause [tenpay](https://github.com/yzhang/tenpay) has been taken and seems not maintain anymore.

## Demo

see <https://github.com/jasl/tenpay_demo> .

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jasl_tenpay'
```

or development version

```ruby
gem 'jasl_tenpay', :github => 'jasl/tenpay'
```

And then execute:

```sh
$ bundle
```

## Usage

### Generate payment url

e.g:

```ruby
options = {
  :out_trade_no      => 'YOUR_ORDER_ID',         # 20130801000001
  :subject           => 'YOUR_ORDER_SUBJECCT',   # Fitbit flex
  :body              => 'YOUR_ORDER_DESCRIPTION',# from knewone.com
  :total_fee         => 1,                       # price, unit: cent
  :spbill_create_ip  => request.ip,              # user ip
  :return_url        => 'YOUR_ORDER_RETURN_URL', # http://knewone.com/orders/1/tenpay_callback
  :notify_url        => 'YOUR_ORDER_NOTIFY_URL'  # http://knewone.com/orders/1/tenpay_notify
}

JaslTenpay::Service.create_interactive_mode_url(options, pid, jkey)
# => 'https://gw.tenpay.com/gateway/pay.htm?...'
```

BTW: Wechat payment using the same api, addition needs provide argument ```:bank_type => 'WX'```

You can redirect user to this payment url, and user will see a payment page for his/her order.

read [Tenpay integration manual](http://help.tenpay.com/mch/) to get more options.

### Verify notify

```ruby
# example in rails
# The notify url MUST be set when generate payment url
# IMPORTANT: Notify may reach earlier than callback
def tenpay_notify
  if JaslTenpay::Notify.verify?(params.except(*request.path_parameters.keys), pid, jkey) && callback_params[:trade_state] == '0'
    # TODO: valid notify, code your business logic here.
  else
    # TODO: invalid, something went wrong, handle it.
  end
  render text: 'success'
end
```

## Contributing

Bug report or pull request are welcome.

### Make a pull request

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Please write unit test with your code if necessary.

## License

This project rocks and uses MIT-LICENSE.
