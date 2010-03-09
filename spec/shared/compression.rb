shared_examples_for 'A compressed page' do

  it "should have a Content-Encoding header with the value 'gzip'" do
    @page.response['content-encoding'].should == 'gzip'
  end

  it "should be gzipped" do
    raw = open(@url, 'Accept-Encoding' => 'gzip')
    body = nil
    -> do
      body = Zlib::GzipReader.new(raw).read
    end.should_not raise_error
    body.should =~ /Read Ruby/
  end
end
