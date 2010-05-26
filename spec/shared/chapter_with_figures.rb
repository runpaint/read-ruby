require_relative '../spec_helper'

require_relative './compression'
require_relative './no_compression'
require_relative './chapter_page'
require_relative './figures'

shared_examples_for 'A chapter with figures' do
  before(:all) do
    @url = BASE_URL + @chapter.to_s
  end

  describe " with compression: " do
    it_should_behave_like 'A compressed page'
    it_should_behave_like 'A chapter page'
    it_should_behave_like 'A page with figures'
  end

  describe " without compression: " do
    it_should_behave_like 'An uncompressed page'
    it_should_behave_like 'A chapter page'
    it_should_behave_like 'A page with figures'
  end
end
