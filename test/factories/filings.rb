# == Schema Information
#
# Table name: filings
#
#  id             :integer          not null, primary key
#  company_id     :integer
#  title          :string(255)
#  url            :string(255)
#  links          :string(255)
#  summary        :string(255)
#  updated        :date
#  categories     :string(255)
#  file_id        :string(255)
#  cik            :string(255)
#  filingtext     :text
#  stockticker    :string(255)
#  footnote       :text
#  periodofreport :date
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :filing do
    title "MyString"
    url "MyString"
    links "MyString"
    summary "MyString"
    updated "2014-02-05"
    categories "MyString"
    id "MyString"
  end
end
