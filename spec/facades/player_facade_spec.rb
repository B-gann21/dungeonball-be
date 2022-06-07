require 'rails_helper'

RSpec.describe PlayerFacade do
  context 'class methods' do
    it '.recent_tweet_count(name) returns an integer of recent tweets' do
      response_body = File.read("spec/fixtures/recent_tweets.json")
      stub_request(:get, "https://api.twitter.com/2/tweets/counts/recent?query=von%20miller").
        with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>ENV['twitter_api_bearer_token'],
            'User-Agent'=>'Faraday v2.3.0'
          }).
          to_return(status: 200, body: response_body, headers: {})

      result = PlayerFacade.recent_tweet_count('von miller')
      expect(result).to be_a Integer
      expect(result).to eq 1183
    end

    it '.class_info(name) creates a DndClass object' do
      monk_response = File.read('spec/fixtures/dnd_monk_response.json')
      stub_request(:get, "https://www.dnd5eapi.co/api/classes/monk").
         with(
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent'=>'Faraday v2.3.0'
           }).
         to_return(status: 200, body: monk_response, headers: {})
      
      result = PlayerFacade.class_info('Monk')

      expect(result).to be_a DndClass
      expect(result.name).to eq 'Monk'
    end
  end
end
