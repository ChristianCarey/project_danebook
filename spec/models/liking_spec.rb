require 'rails_helper'

RSpec.describe Liking, type: :model do
  
  let(:liking) { build(:liking) }

  context "composite key" do 
    
    let(:identical_liking) do 
      build(:liking, user_id: liking.user_id, 
                     likable_id: liking.likable_id,
                     likable_type: liking.likable_type)
    end

    before do 
      liking.save
    end

    it "must be unique" do 
      expect(identical_liking).not_to be_valid
    end
  end
  
  context "belongs to" do 
    
    specify "user" do 
      expect(liking).to respond_to(:user)
    end

    specify "likable" do 
      expect(liking).to respond_to(:likable)
    end
  end
end
