require_relative '../spec_helper'

require_relative './compression'
require_relative './no_compression'
require_relative './chapter_page'

shared_examples_for 'A chapter' do
  before(:all) do
    @url = BASE_URL + @chapter.to_s
  end

  describe " with compression: " do
    it_should_behave_like 'A compressed page'
    it_should_behave_like 'A chapter page'
  end

  describe " without compression: " do
    it_should_behave_like 'An uncompressed page'
    it_should_behave_like 'A chapter page'
  end
end
