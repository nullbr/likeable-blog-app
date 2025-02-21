require "rails_helper"

RSpec.describe Rating do
  describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end

  describe "Validations" do
    it { is_expected.to validate_numericality_of(:value).only_integer }
    it { is_expected.to validate_numericality_of(:value).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_numericality_of(:value).is_less_than_or_equal_to(5) }
  end
end
