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

  it 'should return correct version string' do
    Micropost.version_string.should == "Postler version #{Postler::VERSION}"
  end

  context "when it contains hashtags" do

    it "they are identified" do
      micropost.text = "Testpost in #ginkgo with bla#blub #content"
      micropost.parse

      micropost.hashtags.size.should == 2
    end

  end

  context "when it contains user mentions" do

    it "they are identified" do
      micropost.text = "Testpost from @me to @admin #tag"
      micropost.parse

      micropost.user_mentions.size.should == 2
    end

  end

end