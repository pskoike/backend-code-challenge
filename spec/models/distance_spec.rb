require 'rails_helper'
RSpec.describe Distance, type: :model do
  it { should validate_presence_of(:origin) }
  it { should validate_presence_of(:destination) }
  it { should validate_presence_of(:km) }
  it { should validate_numericality_of(:km).  is_greater_than(0).is_less_than_or_equal_to(100_000)}
end
