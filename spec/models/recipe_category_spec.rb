require 'rails_helper'

RSpec.describe RecipeCategory, type: :model do
  context "associations" do
    it {should belong_to :recipe}
    it {should belong_to :category}
  end

end
