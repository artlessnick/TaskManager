FactoryBot.define do
  sequence :string, aliases: [:first_name, :last_name, :password, :avatar] do |n|
    "string#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :task, aliases: [:name, :description] do |n|
    "string#{n}"
  end

  sequence :expired_at do
    (Time.now + 3.days).strftime('%Y-%m-%d')
  end
end
