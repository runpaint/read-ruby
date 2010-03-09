require_relative '../spec_helper'

require_relative './no_compression'
require_relative './any_page'
require_relative './compression'

shared_examples_for 'A chapter' do
  before(:all) do
    @url = BASE_URL + @chapter.to_s
  end

  describe " with compression: " do
    before(:all) do
      @page = ua_gzip.cached_get(@url)
    end

    it_should_behave_like 'Any page'
    it_should_behave_like 'A compressed page'
  end

  describe " without compression: " do
    before(:all) do
      @page = ua_no_gzip.cached_get(@url)
    end

    it_should_behave_like 'Any page'
    it_should_behave_like 'An uncompressed page'
  end
end
