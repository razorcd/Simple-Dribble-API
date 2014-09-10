puts '-'*75
require_relative '../../spec_helper.rb'

describe "Dish API must exist" do
  it "have access to Player class" do
    player = Dish::Player.new('simplebits')
    player.must_be_instance_of Dish::Player
  end


  describe "GET profile" do

    let(:player) {Dish::Player.new('simplebits')}

    before do
      VCR.insert_cassette('dribbbler', :record => :new_episodes)
    end

    after do
      VCR.eject_cassette
    end

    it "include HTTParty and GET hash" do
      player.profile.must_be_instance_of Hash
    end

    it "have correct username" do
      player.profile['username'].must_equal 'simplebits'
    end

    it 'return all attributes with missing_method' do
      player.id.must_equal 1
    end

    it 'raise NoMethodError if attribute not found' do
      lambda {player.foo_attribute}.must_raise NoMethodError
    end



    describe "chaching" do

      before do
        player.profile #load once
      stub_request(:any, /api.dribbble.com/).to_timeout
      end
      
      it "return same player once recorderd without another HTTP request" do
        #HTTP requests are blocked and player should be returned from recodings
        player.profile.must_be_instance_of Hash
        player.profile['id'].must_equal 1
      end

      it "force GET request on player.profile(true)" do
        #HTTP requests are blocked and player should be returned from recodings
        lambda {player.profile(true)}.must_raise Timeout::Error
      end
    end

  end




end