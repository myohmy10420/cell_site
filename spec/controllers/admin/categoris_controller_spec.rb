RSpec.describe Admin::CategoriesController, type: :controller do
  before do
    sign_in(create(:admin_user))
  end

  describe "DELETE destroy" do
    it "assigns @category" do
      category = create(:category)

      delete :destroy, params: { id: category.id }

      expect(assigns[:category]).to eq(category)
    end

    it "deletes a record" do
      category = create(:category)

      expect {
        delete :destroy, params: { id: category.id }
      }.to change { Category.count }.by(-1)
    end

    it "redirects to edit_brand_path" do
      brand = create(:brand)
      category = create(:category, brand_id: brand.id)

      delete :destroy, params: { id: category.id }

      expect(response).to redirect_to edit_admin_brand_path(brand)
    end
  end
end
