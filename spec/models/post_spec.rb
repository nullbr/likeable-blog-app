require "rails_helper"

RSpec.describe Post do
  describe "Associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }

    it "is valid with valid ip" do
      post = build(:post)
      expect(post).to be_valid
    end

    it "is invalid with bad ip" do
      post = build(:post, ip: "123456")
      expect(post).not_to be_valid
    end
  end

  describe "#average_rating" do
    let(:user) { create(:user) }
    let(:post) { create(:post, user: user) }

    context "when there are ratings for the post" do
      before do
        create(:rating, post: post, user: user, value: 4)
        create(:rating, post: post, user: user, value: 5)
        create(:rating, post: post, user: user, value: 3)
      end

      it "returns the correct average rating" do
        expect(post.average_rating).to eq(4.0)
      end
    end

    context "when there are no ratings for the post" do
      it "returns 0.0 as the average rating" do
        expect(post.average_rating).to eq(0.0)
      end
    end
  end
end
