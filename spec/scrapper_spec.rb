RSpec.describe ImeiScrapper::Scrapper do

  let(:expired_warranty_html) { File.open(File.expand_path('../fixtures/hw_expired.html', __FILE__), 'rb').read }
  let(:not_expired_warranty_html) { File.open(File.expand_path('../fixtures/hw_not_expired.html', __FILE__), 'rb').read }
  let(:invalid_imei_html) { File.open(File.expand_path('../fixtures/invalid_imei.html', __FILE__), 'rb').read }
  let(:scrapper) { ImeiScrapper::Scrapper.new('test_imei') }

  describe '#request' do
    before(:each) do
      stub_request(:post, ImeiScrapper::Scrapper::SCRAP_URL)
    end

    it 'sends a POST request with correct params' do
      scrapper.request
      expect(WebMock).to have_requested(:post, ImeiScrapper::Scrapper::SCRAP_URL)
        .with(:body => {sn: 'test_imei', num: ImeiScrapper::Scrapper::NUMBER_PARAM})
    end
  end

  describe '#get_info' do
    it 'returns expired warranty info' do
      stub_request(:post, ImeiScrapper::Scrapper::SCRAP_URL)
        .to_return(:status => 200, :body => expired_warranty_html, :headers => {})
      info = scrapper.get_info
      expect(info).to include(hw_warranty: false)
      expect(info).to include(expiration_date: nil)
    end

    it 'returns not expired warranty info' do
      stub_request(:post, ImeiScrapper::Scrapper::SCRAP_URL)
        .to_return(:status => 200, :body => not_expired_warranty_html, :headers => {})
      info = scrapper.get_info
      expect(info).to include(hw_warranty: true)
      expect(info).to include(expiration_date: Date.parse('August 10, 2016'))
    end

    it 'returns nil if imei is invalid' do
        stub_request(:post, ImeiScrapper::Scrapper::SCRAP_URL)
        .to_return(:status => 200, :body => invalid_imei_html, :headers => {})
        info = scrapper.get_info
        expect(info).to eq(nil)
    end
  end

end