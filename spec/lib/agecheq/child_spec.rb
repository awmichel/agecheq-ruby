require 'agecheq'

describe AgeCheq::Child do
  subject { AgeCheq::Child.new('test_pin') }

  before do
    AgeCheq.configure do |config|
      config.api_key = "test_key"
      config.application_id = "test_app"
    end
  end

  it 'should initialize with pin' do
    expect(subject.pin).to eq('test_pin')
  end

  it 'should set developer key for basic auth' do
    options = subject.class.default_options
    expect(options[:basic_auth]).to eq({username: 'test_key', password: ' '})
  end

  it 'should set base URI' do
    options = subject.class.default_options
    expect(options[:base_uri]).to eq('https://api.agecheq.com/applications/test_app')
  end

  it 'should raise InvalidCommand error from response' do
    response = { rtn: 'fail', rtnmsg: 'invalid command' }.to_json
    stub_request(:get, /api.agecheq.com/).
      to_return(status: 200, body: response)
    expect { subject.check }.to raise_error(AgeCheq::InvalidCommand)
  end

  it 'should raise InvalidAgeCheqPin error from response' do
    response = { rtn: 'fail', rtnmsg: 'invalid child agecheq pin' }.to_json
    stub_request(:get, /api.agecheq.com/).
      to_return(status: 200, body: response)
    expect { subject.check }.to raise_error(AgeCheq::InvalidAgeCheqPin)
  end

  it 'should raise UnknownFailure error from response' do
    response = { rtn: 'fail', rtnmsg: 'new error type' }.to_json
    stub_request(:get, /api.agecheq.com/).
      to_return(status: 200, body: response)
    expect { subject.check }.to raise_error(AgeCheq::UnknownFailure).with_message('new error type')
  end

  it 'should return data from check request' do
    response = "{\"rtn\":\"ok\",\"rtnmsg\":\"\",\"data\":{\"apiversion\":3,\"checktype\":0,\"appid\":\"e6fea536-01fc-43e3-a4cf-a5fc5d66d6a3\",\"acpin\":\"test_pin\",\"appauthorized\":true,\"appblocked\":false,\"parentverified\":1,\"under13\":true,\"under18\":true,\"underdevage\":false,\"trials\":0}}"
    stub_request(:get, /api.agecheq.com/).
      to_return(status: 200, body: response)
    expect(subject.check).to eq(JSON.parse("{\"apiversion\":3,\"checktype\":0,\"appid\":\"e6fea536-01fc-43e3-a4cf-a5fc5d66d6a3\",\"acpin\":\"test_pin\",\"appauthorized\":true,\"appblocked\":false,\"parentverified\":1,\"under13\":true,\"under18\":true,\"underdevage\":false,\"trials\":0}"))
  end

  it 'should return data from associate request' do
    response = "{\"rtn\":\"ok\",\"rtnmsg\":\"\",\"data\":{\"apiversion\":3}}"
    stub_request(:get, /api.agecheq.com/).
      to_return(status: 200, body: response)
    expect(subject.associate('TESTDATA')).to eq({"apiversion"=>3})
  end
end
