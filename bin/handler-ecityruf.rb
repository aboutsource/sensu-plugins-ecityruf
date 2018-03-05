#!/usr/bin/env ruby
#
# Sensu Handler: ecityruf
#
# This handler formats alerts and sends them off to the ecityruf service.
#
# Copyright 2018 Hauke Altmann, about source GmbH
#
# Released under the same terms as Sensu (the MIT license); see LICENSE
# for details.

require 'net/https'
require 'sensu-handler'
require 'timeout'

class Ecityruf < Sensu::Handler
  def event_name
    @event['client']['name'] + '/' + @event['check']['name']
  end

  def handle
    apiurl = settings['ecityruf']['url'] || 'https://inetgateway.emessage.de/cgi-bin/funkruf2.cgi'

    params = {
      'action' => 'SendMessage',
      'class' => '4',
      'language' => settings['ecityruf']['language'] || 'de',
      'number' => settings['ecityruf']['number'],
      'lengthAlert' => '',
      'service' => '1',
      'message' => event_name + '/' + @event['check']['output']
    }

    uri = URI.parse(apiurl)
    uri.query = URI.encode_www_form(params)

    Timeout.timeout(60) do
      Net::HTTP.start(uri.host,
                      uri.port,
                      use_ssl: uri.scheme == 'https',
                      verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
        request = Net::HTTP::Get.new uri

        response = http.request request
        puts response.code
      end
      puts 'ecityruf -- sent alert ' + event_name + ' to number ' + params['number'] + '.'
    end
  end
end
