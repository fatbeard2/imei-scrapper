RSpec.describe ImeiScrapper::JSParser do

  let(:parser) { ImeiScrapper::JSParser }
  it 'parses imei data from html' do
    has_hw_support = File.open(File.expand_path('../fixtures/hw_not_expired.html', __FILE__), 'rb').read
    p parser.parse_imei_data(has_hw_support)
  end

end