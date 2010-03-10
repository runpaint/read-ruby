require_relative './any_page'

shared_examples_for 'An HTML page' do
  def internal_links
    @page.links_with(:href => %r{^(#|/)[^/]}).
      map{|u| @url + u.href}
  end

  it "should feature the book title" do
    @page.body.should =~ /Read Ruby/
  end

  it "should have the book title in <title>" do
    @page.title.should =~ /Read Ruby/
  end

  it "should have a Content-Type header with 'text/html' as the value" do
    @page.response['content-type'].should =~ %r{^text/html}
  end

  it "should have internal links" do
    internal_links.should_not be_empty
  end

  it "should have no broken internal links" do
    internal_links.each do |url|
      url.should be_a_working_link
    end
  end

  it "should be valid HTML5" do
    @page.body.should be_html5
  end

  it_should_behave_like 'Any page'
end
