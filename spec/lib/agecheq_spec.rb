describe AgeCheq do
  it 'should be configurable' do
    AgeCheq.configure do |config|
      config.api_key = "test"
      config.application_id = "app_test"
    end

    expect(AgeCheq.configuration.api_key).to eq('test')
    expect(AgeCheq.configuration.application_id).to eq('app_test')
  end

  context 'test configuration state' do
    it 'should not be configured when api key is not set' do
      AgeCheq.configure do |config|
        config.application_id = "test_app"
      end
      expect(AgeCheq.configuration.configured?).to eq(false)
    end

    it 'should not be configured when application id is not set' do
      AgeCheq.configure do |config|
        config.api_key = "test_key"
      end
      expect(AgeCheq.configuration.configured?).to eq(false)
    end

    it 'should not be configured when nothing is set' do
      expect(AgeCheq.configuration.configured?).to eq(false)
    end

    it 'should be configured when all keys are set' do
      AgeCheq.configure do |config|
        config.api_key = "test_key"
        config.application_id = "test_app"
      end
      expect(AgeCheq.configuration.configured?).to eq(true)
    end
  end
end
