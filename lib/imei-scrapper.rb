require 'net/http'

module ImeiScrapper
  class Scrapper
    attr_accessor :imei

    def initialize(imei)
      @imei = imei
    end

    def scrap
      uri = URI('https://selfsolve.apple.com/wcResults.do')
      req = Net::HTTP::Post.new(uri)
      req.set_form_data('sn' => @imei, 'num' => 'blah-blah')
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    end
  end
end