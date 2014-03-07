# == Schema Information
#
# Table name: watch_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  companycik :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :watch_list do
    name "MyString"
  end
end
