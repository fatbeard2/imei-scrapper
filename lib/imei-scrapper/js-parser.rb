module ImeiScrapper
  class JSParser
    BOOL_ARG_PATTERN = /\s*(true|false)\s*/
    STRING_ARG_PATTERN = /\s*('.*?')\s*/
      PATTERN = /warrantyPage\.warrantycheck\.displayHWSupportInfo\(#{BOOL_ARG_PATTERN},(#{STRING_ARG_PATTERN},){3,}\)/

    def self.parse_imei_data html
      p PATTERN
      html.match PATTERN
    end
  end
end
