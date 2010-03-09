require_relative '../spec_helper'

require_relative '../shared/chapter'

describe "/variables" do
  before(:all) do
    @chapter = :variables
  end

  it_should_behave_like 'A chapter'
end
