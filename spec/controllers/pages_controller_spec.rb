RSpec.describe PagesController, type: :controller do
  describe 'GET home' do
    it 'assigns instance variables by order' do
      # Order by sort
      ad1 = create(:carousel_ad)
      ad2 = create(:carousel_ad)
      ad1.update(sort: ad2.sort + 1)

      # Order by updated_at
      early_time = Time.zone.now
      later_time = early_time + 1.second

      product1 = create(:product, is_new: true, is_pop: true, updated_at: early_time)
      product2 = create(:product, is_new: true, is_pop: true, updated_at: later_time)
      product3 = create(:product, is_unlisted: true, updated_at: early_time)
      product4 = create(:product, is_unlisted: true, updated_at: later_time)

      get :home
      expect(assigns[:carousel_ads]).to eq([ad2, ad1])
      expect(assigns[:new_products]).to eq([product2, product1])
      expect(assigns[:pop_products]).to eq([product2, product1])
      expect(assigns[:unlisted_products]).to eq([product4, product3])
    end

    it 'render template' do
      get :home
      expect(response).to render_template('home')
    end
  end
end
