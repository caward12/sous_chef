require 'rails_helper'

RSpec.describe GroceryList, type: :model do

  context "associations" do
    it {should have_many :grocery_list_items}
  end
end
