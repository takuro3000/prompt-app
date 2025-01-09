require 'rails_helper'

RSpec.describe Prompt, type: :model do
  let(:prompt) { build(:prompt) }
  it "is valid with a valid text" do
    expect(prompt).to be_valid
  end
  it "is not valid without a text" do
    prompt.text = ''
    expect(prompt).to_not be_valid
  end
  it "is not valid with a text longer than 140" do
    prompt.text = Faker::Lorem.characters(number: 141)
    expect(prompt).to_not be_valid
  end
end
