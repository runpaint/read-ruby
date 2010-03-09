shared_examples_for 'Any page' do

  def internal_links
    @page.links_with(:href => %r{^(#|/)[^/]}).
      map{|u| @url + u.href}
  end

  it "should exist" do
    @url.should be_a_working_link
  end
  
  it "should feature the book title" do
    @page.body.should =~ /Read Ruby/
  end

  it "should have the book title in <title>" do
    @page.title.should =~ /Read Ruby/
  end

  it "should contain the page name in the title" do
    @page.title.should =~ /#@name/
  end

  it "should have a Content-Type header with 'text/html' as the value" do
    @page.response['content-type'].should =~ %r{^text/html}
  end

  it "should have a Content-Type header with UTF-8 as the character set" do
    @page.response['content-type'].should =~ /charset=UTF-8/i
  end

  it "should have a Content-Language header with 'en-GB' as the value" do
    @page.response['content-language'].should == 'en-GB'
  end

  it "should have internal links" do
    internal_links.should_not be_empty
  end

  it "should have no broken internal links" do
    internal_links.each do |url|
      url.should be_a_working_link
    end
  end
end
