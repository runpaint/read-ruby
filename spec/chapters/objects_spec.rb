require_relative '../spec_helper'

require_relative '../shared/chapter'

describe "/objects" do
  before(:all) do
    @chapter = :objects
  end

  it_should_behave_like 'A chapter'
end
