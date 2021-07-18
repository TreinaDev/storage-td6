require 'rails_helper'

describe Product do
  it { should validate_presence_of(:sku) }
  it { should validate_uniqueness_of(:sku) }
  it { should have_many(:items) }
end
