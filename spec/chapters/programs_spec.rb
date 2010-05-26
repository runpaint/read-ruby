require_relative '../spec_helper'

require_relative '../shared/chapter'

describe "/programs" do
  before(:all) do
    @chapter = :programs
  end

  it_should_behave_like 'A chapter'
end
