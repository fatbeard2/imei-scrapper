require 'date'

module ImeiScrapper
  class JSParser
    DATE_PATTERN = /Expiration Date: (.*? \d\d, \d\d\d\d)/
    BOOL_ARG_PATTERN = /\s*(true|false)\s*/
    STRING_ARG_PATTERN = /\s*('.*?')\s*/
    HW_FUNC_PATTERN = /warrantyPage\.warrantycheck\.displayHWSupportInfo\(#{BOOL_ARG_PATTERN.source},#{STRING_ARG_PATTERN.source},#{STRING_ARG_PATTERN.source}/

    def self.parse_hw_data(text)
      match_data = text.match HW_FUNC_PATTERN
      raise ParseException if match_data.nil?
      { hw_warranty: to_boolean(match_data[1]), expiration_date: extract_date(match_data[3]) }
    end

    def self.extract_date(string)
      begin
        raw_date = string.match DATE_PATTERN
        raw_date ? Date.parse(raw_date[0]) : nil
      rescue ArgumentError
        nil
      end
    end

    def self.to_boolean(str)
      str == 'true'
    end

  end
end
