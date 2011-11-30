require 'spec_helper'

describe Adhearsion::Rails do

  subject { Adhearsion::Rails }

  it "should be a module" do
    subject.should be_kind_of Module
  end
end
