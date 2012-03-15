require 'spec_helper.rb'

describe NestedSelect::Tree do
  it "creates root node" do
    subject.root_node.should_not be_nil
  end

  it "adds item to a tree" do
    item = NestedSelect::Item.new("a",25)
    subject.add_item(item)
  end

  it "puts item into root node if item level is 0" do
    item = NestedSelect::Item.new("a",25)
    subject.add_item(item)
    subject.root_node["a"] == item
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