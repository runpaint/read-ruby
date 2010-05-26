require_relative './html_page'
require 'tempfile'

shared_examples_for 'A chapter page' do
  it "should contain the chapter name in the title" do
    @page.title.should =~ /#@chapter/i
  end

  it "should contain the chapter name in first <h1>" do
    @page.parser.at('h1').inner_text.should =~ /#@chapter/i
  end

  it "should contain a link to the chapter stylesheet" do
    stylesheet = @page.parser.at('link[rel=stylesheet]')
    stylesheet.should_not be_nil
    stylesheet['href'].should == '/chapter'
  end

  it "should contain a link to the license" do
    license = @page.parser.at('link[rel=license]')
    license.should_not be_nil
    license['href'].should =~ /creativecommons\.org/
  end

  it "should contain a link to the ToC" do
    up = @page.parser.at('link[rel="index up"]')
    up.should_not be_nil
    up['href'].should == '/toc'
  end

  it "should contain Analytics code" do
    @page.body.should include('google-analytics.com')
  end

  it "should contain a <meta> tag specifying UTF-8 as the character set" do
    @page.parser.at('meta[charset=utf-8]')['charset'].should == 'utf-8'
  end

  it "should contain multiple headed sections" do
    @page.parser.css('section > h1').size.should > 1
  end

  it "should not contain duplicate IDs" do
    ids = @page.parser.css('[id]').map{|e| e['id']}
    ids.uniq.should == ids
  end

  it "should assign IDs to each <h1>" do
    (@page.parser.css('h1') - @page.parser.css('h1[id]')).to_a.should == []
  end

  def raises(file)
    Tempfile.open('spawn') do |temp|
      pid = spawn("ruby #{file}", err: temp.path, out: :close)
      begin
        Timeout.timeout(2) do
          break if Process.waitpid2(pid).last.success? 
          /\((?<e>[A-Z][a-z]\w+)\)\n/ =~ (error = temp.read)
          return e if e and e = Object.const_get(e) and e < Exception
          SyntaxError
        end
      rescue TimeoutError => e
        Process.kill(:KILL, pid)
        e.class
      end
    end
  end

  it "does not contain figures that unexpectedly raise exceptions" do
    @page.parser.css('figure[id]').each do |fig|
      next unless fig['id'].end_with?('.rb')
      file = "examples/#{fig['id']}"
      if ex = raises(file) and not File.read(file).include?(ex.to_s)
        if ex == TimeoutError
          File.should exist("timeouts/#{File.basename fig['id']}")
        else
          ex.should_not be_an(Exception)
        end
      end
    end
  end

  it_should_behave_like 'An HTML page'
end
