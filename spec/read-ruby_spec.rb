require_relative './spec_helper'
describe "Root page" do
  before(:all) do
    @url = 'http://ruby.runpaint.org/'
    @ua = Mechanize
  end

  describe " for clients supporting compression" do
    before(:all) do
      @page = @ua.new.get @url
    end

    it "should feature the book title" do
      @page.body.should =~ /Read Ruby/
    end

    it "should have a Content-Type header with 'text/html' as the value" do
      @page.response['content-type'].should be_start_with('text/html')
    end

    it "should have a Content-Type header with UTF-8 as the character set" do
      @page.response['content-type'].should =~ /charset=UTF-8/i
    end

    it "should have a Content-Language header with 'en-GB' as the value" do
      @page.response['content-language'].should == 'en-GB'
    end

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

  describe " for clients not supporting compression" do
    before(:all) do
      @page = @ua.new.tap{|m| m.gzip_enabled = false}.get @url
    end

    it "should feature the book title" do
      @page.body.should =~ /Read Ruby/
    end

    it "should have a Content-Type of text/html" do
      @page.response['content-type'].should be_start_with('text/html')
    end

    it "should have a Content-Type charset of UTF-8" do
      @page.response['content-type'].should =~ /charset=UTF-8/i
    end

    it "should have a Content-Language of en-GB" do
      @page.response['content-language'].should == 'en-GB'
    end

    it "should not have a Content-Encoding header" do
      @page.response.should_not have_key('content-encoding')
    end

    it "should not be gzipped" do
      raw = open(@url)
      body = raw.dup.read
      -> do
        Zlib::GzipReader.new(raw).read
      end.should raise_error(Zlib::Error)
      body.should =~ /Read Ruby/
    end
  end
end
