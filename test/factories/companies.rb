# == Schema Information
#
# Table name: companies
#
#  id        :integer          not null, primary key
#  name      :string(255)
#  cik       :string(255)
#  industry  :string(255)
#  filing_id :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "MyString"
    cik "MyString"
    industry "MyString"
  end
end
