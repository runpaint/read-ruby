require_relative '../spec_helper'

require_relative '../shared/chapter'

describe "/text" do
  before(:all) do
    @chapter = :text
  end

  it_should_behave_like 'A chapter'
end
