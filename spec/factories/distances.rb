FactoryBot.define do
  factory :distance do
    # origin "A"
    # destination "C"
    # km 10
    origin [*('A'..'C')].sample
    destination [*('A'..'C')].sample
    km 10
  end
end
