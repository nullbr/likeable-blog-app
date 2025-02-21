require "rails_helper"

RSpec.describe User do
  describe "Associations" do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:ratings) }
  end

  describe "Validations" do
    subject { build(:user, login: "test user") }

    it { is_expected.to validate_presence_of(:login) }
    it { is_expected.to validate_uniqueness_of(:login) }
  end
end
