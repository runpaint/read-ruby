require_relative '../spec_helper'

require_relative '../shared/chapter'

describe "/messages" do
  before(:all) do
    @chapter = :messages
  end

  it_should_behave_like 'A chapter'
end
