require 'spec_helper'

describe "Micropost" do
  let(:micropost) { Micropost.new }

  subject { micropost }

  # Micopost is invalid without a text
  it { should_not be_valid}

  it "is valid with text" do
    micropost.text = "Testpost"
    micropost.should be_valid
  end

  it "is invalid if text has more than 140 characters" do
    micropost.text = "a" * 160
    micropost.should_not be_valid
  end

  it 'should return correct version string' do
    Postler::VERSION.match(/(^\d\.\d.\d$)/).should_not be_nil
  end

  context "when it contains hashtags" do

    it "identifies them" do
      micropost.text = "Testpost in #ginkgo with bla#blub #content"
      micropost.parse

      micropost.hashtags.size.should == 2
    end

  end

  context "when it contains user mentions" do

    it "identifies them" do
      micropost.text = "Testpost from @me to @admin #tag"
      micropost.parse

      micropost.user_mentions.size.should == 2
    end

  end

  context "when it contains event mentions" do

    it "identifies them" do
      micropost.text = "Testpost from @me to @admin #tag at +event1"
      micropost.parse

      micropost.events.size.should == 1
    end

  end

end