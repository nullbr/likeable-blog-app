require "rails_helper"

RSpec.describe User do
  describe "Associations" do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:ratings) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:login) }
  end
end
