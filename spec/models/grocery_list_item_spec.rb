require 'rails_helper'

RSpec.describe GroceryListItem, type: :model do
  context "validations" do
    it {should validate_presence_of(:item)}
  end

  context "associations" do
    it {should belong_to :grocery_list}
  end
end
