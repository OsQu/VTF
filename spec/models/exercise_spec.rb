require 'spec_helper'

describe Exercise do
  describe "validation" do
    it "should allow correct cateogry" do
      e = Exercise.new category: "XSS", name: "Ex 1.", description: "Blabla"
      e.save!

      Exercise.find_by_name("Ex 1.").should_not be_nil
    end

    it "should not allow invalid cateogy" do
      e = Exercise.new category: "Invalid", name: "Ex 1.", description: "Blabla"
      expect {
        e.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should validate precense of name" do
      e = Exercise.new category: "XSS", description: "Blabla"
      expect {
        e.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
