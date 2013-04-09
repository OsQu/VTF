require 'spec_helper'

describe Exercise do
  describe "validation" do
    it "should validate precense of name" do
      category = FactoryGirl.create :category
      e = Exercise.new description: "Blabla"
      expect {
        e.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
