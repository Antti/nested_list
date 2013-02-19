require 'spec_helper.rb'

describe NestedSelect::Tree do
  it "creates root node" do
    subject.root_node.should_not be_nil
  end

  it "puts item into root node if item level is 0" do
    item = NestedSelect::Item.new("a",25)
    subject.add_item(item)
    subject.root_node["a"].content.should eq(item)
  end

  context "empty root" do
    it "puts item in a correct tree level and creates virtual nodes" do
      item = NestedSelect::Item.new("a>b>c",25)
      subject.add_item(item)
      subject.root_node["a"]["b"]["c"].content.should == item
      subject.root_node["a"].content.should be_virtual
      subject.root_node["a"]["b"].content.should be_virtual
    end
  end

  it "puts item into correct node" do
    item = NestedSelect::Item.new("a>b>c",25)
    subject.add_item(item)
    item2 = NestedSelect::Item.new("a>b>x",20)
    subject.add_item(item2)
    subject.root_node["a"]["b"]["x"].content.should == item2
  end

  it "adds item with blank name and substitutes it to 'unknown category'" do
    item = NestedSelect::Item.new(">b>c",25)
    subject.add_item(item)
    subject.root_node["unknown category"]["b"]["c"].content.should be
  end

  it "replaces virtual item with real one" do
    item = NestedSelect::Item.new("a>b>c",25)
    subject.add_item(item)
    item2 = NestedSelect::Item.new("a>b",12)
    subject.add_item(item2)
    subject.root_node["a"]["b"].content.should == item2
  end

  it "replaces virtual item only on last level" do
    item = NestedSelect::Item.new("a>b>c",25)
    subject.add_item(item)
    item2 = NestedSelect::Item.new("a>b",12)
    subject.add_item(item2)
    subject.root_node["a"].content.should be_virtual
  end

end
