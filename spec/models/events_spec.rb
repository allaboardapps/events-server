require "rails_helper"

describe Event, type: :model do
  it "has a valid factory" do
    expect(create :event).to be_valid
  end

  it "is invalid without a name" do
    expect(build :event, name: nil).to_not be_valid
  end

  it "is invalid without an abbreviation" do
    expect(build :event, abbreviation: nil).to_not be_valid
  end

  it "is invalid without a primary category" do
    expect(build :event, primary_category: nil).to_not be_valid
  end

  it { is_expected.to belong_to :client }
  it { is_expected.to belong_to :location }
  it { is_expected.to have_one :region }
  it { is_expected.to have_many :favorites }
  it { is_expected.to have_many :users }
end
