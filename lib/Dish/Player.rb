module Dish

  class Player
    include HTTParty

    attr_accessor :username

    base_uri 'http://api.dribbble.com'

    def initialize(username)
      self.username = username
    end

    def profile(force = false)
      force ? @profile = get_profile : @profile ||= get_profile
    end

    def get_profile
      self.class.get "/players/#{self.username}"
    end

    def method_missing(meth, *args, &block)
      puts "**************************** missing : #{meth}"
      if profile.has_key?(meth.to_s)
        puts "**************************** key found : #{meth}"
        profile[meth.to_s]
      else
        super
      end

    end

  end

end