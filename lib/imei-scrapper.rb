require 'net/http'
require 'imei-scrapper/js-parser'

module ImeiScrapper
  SCRAP_URL = 'https://selfsolve.apple.com/wcResults.do'
  NUMBER_PARAM = 'blah-blah' #apperantly can be anything, but is required

  class Scrapper
    attr_accessor :imei

    def initialize(imei)
      @imei = imei
    end

    def get_info
      JSParser.parse_imei_data(request.body)
    end

    def request
      uri = URI(SCRAP_URL)
      req = Net::HTTP::Post.new(uri)
      req.set_form_data('sn' => @imei, 'num' => NUMBER_PARAM)
      res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(req)
      end
    end
  end
end