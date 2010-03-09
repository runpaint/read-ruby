shared_examples_for 'An uncompressed page' do
  before(:all) do
    @page = ua_no_gzip.cached_get(@url)
  end

  it "should not have a Content-Encoding header" do
    @page.response.should_not have_key('content-encoding')
  end
    
  it "should not be gzipped" do
    raw = open(@url)
    raw.read.should =~ /Read Ruby/
    raw.rewind
    -> do
      Zlib::GzipReader.new(raw).read
    end.should raise_error(Zlib::Error)
  end
end
