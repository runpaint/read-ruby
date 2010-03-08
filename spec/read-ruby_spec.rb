require_relative './spec_helper'

shared_examples_for 'Root page' do

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
end

describe "Root page" do
  before(:all) do
    @url = 'http://ruby.runpaint.org/'
    @ua = Mechanize
  end

  describe " for clients supporting compression" do
    before(:all) do
      @page = @ua.new.get @url
    end
    
    it_should_behave_like 'Root page'

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

    it_should_behave_like 'Root page'

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
end
