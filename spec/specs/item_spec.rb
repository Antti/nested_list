require 'spec_helper'

describe NestedSelect::Item do
  context "Virtual item" do
    subject { NestedSelect::Item.new("test_cat>test_subcat") }
    it "should be virtual" do
      subject.should be_virtual
    end
    describe '#value' do
      it "should return special id with groups" do
        subject.value.should == 'test_cat-test_subcat:group'
      end
    end
  end
  context "Not virtual item (with id)" do
    subject { NestedSelect::Item.new("test_name",25) }
    it "should not be virtual" do
      subject.should_not be_virtual
    end
    describe '#value' do
      it "should return id" do
        subject.value.should == 25
      end
    end
  end
end