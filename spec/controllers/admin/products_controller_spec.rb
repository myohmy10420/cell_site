RSpec.describe Admin::ProductsController, type: :controller do
  before do
    sign_in(create(:admin_user))
  end

  describe "GET index" do
    it "assigns @products" do
      product1 = create(:complete_datas_product)
      product2 = create(:complete_datas_product)

      get :index

      expect(assigns[:products]).to eq([product1, product2])
    end

    it "render template" do
      get :index

      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "addigns @product" do
      get :new

      expect(assigns(:product)).to be_a_new(Product)
    end

    it "render template" do
      get :new

      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "create a new product record" do
      brand = create(:brand)
      product = build(:product, brand_id: brand.id)

      params = {
        product: {
          brand_id: product.brand.id,
          name: product.name
        }
      }

      expect do
        post :create, params: params
      end.to change{ Product.count }.by(1)
    end

    it "redirects to edit_admin_product_path" do
      brand = create(:brand)
      product = build(:product, brand_id: brand.id)

      params = {
        product: {
          brand_id: product.brand.id,
          name: product.name
        }
      }

      post :create, params: params

      expect(response).to redirect_to edit_admin_product_path(Product.last.friendly_id)
    end
  end

  describe "POST update" do
    it "assign @brand" do
      product = create(:product)

      params = {
        id: product.id,
        product: {
          name: Faker::Name.unique.name
        }.merge(attributes_for(:complete_datas_product))
      }

      put :update , params: params

      expect(assigns[:product]).to eq(product)
    end

    it "changes value" do
      product = create(:complete_datas_product)
      new_name = Faker::Name.unique.name

      params = {
        id: product.id,
        product: {
          name: new_name
        }
      }

      put :update , params: params

      expect(assigns[:product].name).to eq(new_name)
    end

    it "redirects to product_path" do
      product = create(:complete_datas_product)
      params = {
        id: product.id,
        product: {
          name: Faker::Name.unique.name
        }
      }

      put :update , params: params

      expect(response).to redirect_to edit_admin_product_path(product)
    end
  end

  describe "DELETE destroy" do
    it "assigns @product" do
      product = create(:product)

      delete :destroy, params: { id: product.id }

      expect(assigns[:product]).to eq(product)
    end

    it "deletes a record" do
      product = create(:product)

      expect {
        delete :destroy, params: { id: product.id }
      }.to change { Product.count }.by(-1)
    end

    it "redirects to brands_path" do
      product = create(:product)

      delete :destroy, params: { id: product.id }

      expect(response).to redirect_to admin_products_path
    end
  end
end
