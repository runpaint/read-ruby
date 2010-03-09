require_relative './spec_helper'

require_relative './shared/no_compression'
require_relative './shared/any_page'
require_relative './shared/compression'

path = '/messages'

describe path do
  before(:all) do
    @url = BASE_URL + path
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
