require_relative './spec_helper'

describe " /sitemap" do
  before(:all) do
    @url = BASE_URL + '/sitemap'
    @page = ua_gzip.cached_get(@url)
    @urls = Nokogiri::XML(@page.body).
          search('loc').
          map(&:inner_text).
          map{|u| URI.parse(u)}.
          uniq
  end

  it "should exist" do
    @url.should be_a_working_link
  end
  
  it "should contain only working URLs" do
    @urls.each do |url|
      url.should be_a_working_link
    end
  end
  
  it "should link to the root page" do
    @urls.should include(BASE_URL)
  end
  
  it "should link to ToC chapters" do
    %w{methods messages closures}.
      map{|c| BASE_URL + c}.
      each do |url|
        @urls.should include(url)
      end
  end

  it "should link to at least 10 URLs" do
    @urls.size.should > 10
  end

  it "should link to at least 10 .rb files" do
    @urls.select{|u| u.path.end_with?('.rb')}.size.should > 10
  end
end
