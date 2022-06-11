require 'rails_helper'

RSpec.describe Review, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  subject {
    described_class.new(comment: "Anything")
  }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
