shared_examples_for 'Any page' do
  it "should exist" do
    @url.should be_a_working_link
  end
  
  it "should have a Content-Type header with UTF-8 as the character set" do
    @page.response['content-type'].should =~ /charset=UTF-8/i
  end

  it "should have a Content-Language header with 'en-GB' as the value" do
    @page.response['content-language'].should == 'en-GB'
  end
end
