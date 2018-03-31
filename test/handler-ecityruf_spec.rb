require 'json'
require 'webmock/rspec'

require_relative '../bin/handler-ecityruf.rb'

describe HandlerEcityruf do
  before :context do
    ENV['SENSU_CONFIG_FILES'] = '/dev/null'
    HandlerEcityruf.disable_autorun
  end

  before :each do
    allow(STDOUT).to receive(:puts)

    @handler = HandlerEcityruf.new
    @handler.settings['ecityruf'] = { 'number' => '123456' }
  end

  it 'should handle events' do
    event = { id: 'abcd',
              client: { name: 'testclient' },
              check: { name: 'testcheck', output: 'someoutput' } }
    allow(STDIN).to receive(:read).and_return(JSON.generate(event))
    ecityruf = stub_request(:get, 'https://inetgateway.emessage.de/cgi-bin'\
                                  '/funkruf2.cgi?action=SendMessage&class=4'\
                                  '&language=de&lengthAlert='\
                                  '&message=testclient/someoutput'\
                                  '&number=123456&service=1')

    @handler.read_event(STDIN)
    @handler.handle

    expect(ecityruf).to have_been_requested
    expect(STDOUT).to have_received(:puts).with(
      'sent alert testclient/testcheck to number 123456'
    )
    expect(STDOUT).to have_received(:puts).with('response: 200')
  end

  it 'should cut long messages' do
    event = { id: 'abcd',
              client: { name: 'testclient' },
              check: { output: 'Lorem ipsum dolor sit amet, consetetur '\
                               'sadipscing elitr, sed diam nonumy eirmod '\
                               'tempor invidunt ut labore et dolore magna' } }
    allow(STDIN).to receive(:read).and_return(JSON.generate(event))
    ecityruf = stub_request(:get, 'https://inetgateway.emessage.de/cgi-bin'\
                                  '/funkruf2.cgi?action=SendMessage&class=4'\
                                  '&language=de&lengthAlert='\
                                  '&message=testclient/Lorem%20ipsum%20dolor'\
                                  '%20sit%20amet,%20consetetur%20sadipscing'\
                                  '%20elitr,%20sed%20diam%20no'\
                                  '&number=123456&service=1')

    @handler.read_event(STDIN)
    @handler.handle

    expect(ecityruf).to have_been_requested
  end
end
