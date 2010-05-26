shared_examples_for 'A page with figures' do
  it "should contain multiple figures" do
    @page.parser.css('figure').size.should > 1
  end

  it "should contain multiple code samples" do
    @page.parser.css('figure[id]').
      select{|f| f['id'].end_with?('.rb')}.
      size.should > 1
  end

  it "should link code samples to the corresponding example file" do
    @page.parser.css('a').each do |a|
      a.css('figure[id]').
        select{|figure| figure['id'].end_with?('.rb')}.
        each do |figure|
          a['href'].should be_end_with(figure['id'])
        end
    end
  end
end
