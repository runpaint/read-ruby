require_relative '../spec_helper'

require_relative '../shared/chapter_with_figures'

describe "/methods" do
  before(:all) do
    @chapter = :methods
  end

  it_should_behave_like 'A chapter with figures'
end
