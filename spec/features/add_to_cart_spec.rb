require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can click the 'Add to Cart' button for a product on the HP and cart adds +1" do
    # ACT
    visit root_path
    expect(page).to have_text "My Cart (0)"
    product = page.first('article.product')
    button = product.find_button('Add')
    button.click

    # VERIFY
    expect(page).to have_text "My Cart (1)"

    # DEBUG
    save_screenshot
  end
end
