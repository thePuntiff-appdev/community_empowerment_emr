require 'rails_helper'

RSpec.describe Encounter, type: :model do
  
    describe "Direct Associations" do

    it { should belong_to(:location) }

    it { should have_many(:prescriptions) }

    it { should belong_to(:patient) }

    it { should belong_to(:approving_provider) }

    it { should belong_to(:provider) }

    end

    describe "InDirect Associations" do

    end

    describe "Validations" do
      
    end
end
