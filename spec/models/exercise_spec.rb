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

  describe "compile source codes" do
    before :each do
      @exercise = FactoryGirl.create(:exercise,
        name: "Acme Vault", parameterized_name: "acmevault",
        sources: "foo.rb, bar.rb")

      @foo_source = File.read(Rails.root.join("spec", "fixtures", "some_source.rb"))
      @bar_source = File.read(Rails.root.join("spec", "fixtures", "more_source.rb"))

      File.should_receive(:read).with(source_path("acmevault", "foo.rb")).and_return(@foo_source)
      File.should_receive(:read).with(source_path("acmevault", "bar.rb")).and_return(@bar_source)
    end

    it "should scan files using coderay" do
      @exercise.compile_source_codes
    end

    it "should create sourcecode models from source code" do
      expect{
        @exercise.compile_source_codes
      }.to change{SourceCode.count}.by(2)
    end

    it "should set compiled source as source code body" do
      @exercise.compile_source_codes

      compiled_foo = CodeRay.scan(@foo_source, :ruby).html

      foo = SourceCode.find_by_name("foo.rb")
      foo.body.should eq(compiled_foo)
    end

    def source_path(exercise, file)
      Rails.root.join("exercises", exercise, "public_html", "app", file)
    end

  end
end
