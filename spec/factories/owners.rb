FactoryGirl.define do 
    factory :owner do 
        sequence(:email) { |n| "test-#{n}@example.com" }
        password "testtest" 
    end 
end