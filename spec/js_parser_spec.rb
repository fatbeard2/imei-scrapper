
RSpec.describe ImeiScrapper::JSParser do

  let(:parser) { ImeiScrapper::JSParser }

  describe '#parse_hw_data' do
    it 'extracts hardware warranty info' do
      success_page_html = File.open(File.expand_path('../fixtures/hw_not_expired.html', __FILE__), 'rb').read
      parse_result = parser.parse_hw_data(success_page_html)
      expect(parse_result).to include(hw_warranty: true)
      expect(parse_result).to include(expiration_date: Date.parse('August 10, 2016'))
    end

    it 'extracts expired warranty info' do
      success_page_html = File.open(File.expand_path('../fixtures/hw_expired.html', __FILE__), 'rb').read
      parse_result = parser.parse_hw_data(success_page_html)
      expect(parse_result).to include(hw_warranty: false)
      expect(parse_result).to include(expiration_date: nil)
    end

    it 'throws an error if nothing matched' do
      invalid_imei_html = File.open(File.expand_path('../fixtures/invalid_imei.html', __FILE__), 'rb').read
      expect { parser.parse_hw_data(invalid_imei_html) }.to raise_error(ImeiScrapper::ParseException)
    end
  end

  describe '#extract_date' do
    it 'parses expiration date' do
      date = parser.extract_date('blah blah blah<br/>Estimated Expiration Date: August 10, 2016<br/><a href="http://blah"></a>')
      expect(date).to eq(Date.parse('August 10, 2016'))
    end

    it 'returns nil if there is no match' do
      date = parser.extract_date('blah blah blah<br/>Estimated Expiration Date, 2016<br/><a href="http://blah"></a>')
      expect(date).to be_nil
    end

    it 'returns nil if date is incorrect' do
      date = parser.extract_date('blah blah blah<br/>Estimated Expiration Date: Jabruaru 77, 2016<br/><a href="http://blah"></a>')
      expect(date).to be_nil
    end
  end

end