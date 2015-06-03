module ImeiScrapper
  class JSParser
    BOOL_ARG_PATTERN = /\s*(true|false)\s*/
    STRING_ARG_PATTERN = /\s*('.*?')\s*/
    PATTERN = /warrantyPage\.warrantycheck\.displayHWSupportInfo\(#{BOOL_ARG_PATTERN.source},#{STRING_ARG_PATTERN.source},#{STRING_ARG_PATTERN.source}/
  puts PATTERN.source
    def self.parse_imei_data html
      html.match PATTERN
    end
  end
end
