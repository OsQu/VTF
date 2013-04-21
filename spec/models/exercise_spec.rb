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

    describe "parameterized name allows only letters" do
      it "should allow acmevault" do
        ex = Exercise.new name: "Acme Vault", parameterized_name: "acmevault"
        ex.save.should be_true
      end

      it "should not allow AcmeVault" do
        ex = Exercise.new name: "Acme Vault", parameterized_name: "AcmeVault"
        ex.save.should be_false
      end

      it "should not allow 123vault" do
        ex = Exercise.new name: "123 Vault", parameterized_name: "123vault"
        ex.save.should be_false
      end
    end
  end
end
