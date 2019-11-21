RSpec.describe Brand do
  it { should have_many(:products) }
  it { should have_many(:recoveries) }
  it { should have_many(:categories) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
