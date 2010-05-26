require_relative './no_compression'
require_relative './html_page'

shared_examples_for 'An uncompressed HTML page' do
  it_should_behave_like 'An uncompressed page'
  it_should_behave_like 'An HTML page'
end
