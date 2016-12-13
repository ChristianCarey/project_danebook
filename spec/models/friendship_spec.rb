require 'rails_helper'

RSpec.describe Friendship, type: :model do
  
  let(:friendship) { build(:friendship) }
  context "belongs to" do 
    specify "user" do 
      expect(friendship).to respond_to(:user)
    end

    specify "friend" do 
      expect(friendship).to respond_to(:friend)
    end
  end
end
