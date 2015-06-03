require 'net/http'

module ImeiScrapper
  class Scrapper
    SCRAP_URL = 'https://selfsolve.apple.com/wcResults.do'
    NUMBER_PARAM = 'blah-blah' #apperantly can be anything, but is required

    attr_accessor :imei

    def initialize(imei)
      @imei = imei
    end

    def get_info
      begin
        ImeiScrapper::JSParser.parse_hw_data(request.body)
      rescue ParseException
        return nil
      end
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