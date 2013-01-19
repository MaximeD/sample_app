FactoryGirl.define do
  factory :user do
    name                  "Example name"
    email                 "example@foo.bar"
    password              "foobar"
    password_confirmation "foobar"
  end
end
