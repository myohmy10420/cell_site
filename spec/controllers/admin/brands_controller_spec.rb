RSpec.describe Admin::BrandsController, type: :controller do
  before do
    sign_in(create(:admin_user))
  end

  describe "GET index" do
    it "assigns @brands" do
      brand1 = create(:brand)
      brand2 = create(:brand)

      get :index

      expect(assigns[:brands]).to eq([brand1, brand2])
    end

    it "render template" do
      get :index

      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    it "addigns @brand" do
      get :new

      expect(assigns(:brand)).to be_a_new(Brand)
    end

    it "render template" do
      get :new

      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "create a new brand record" do
      expect do
        post :create, params: { brand: attributes_for(:brand) }
      end.to change{ Brand.count }.by(1)
    end

    it "redirects to brands_path" do
      post :create, params: { brand: attributes_for(:brand) }

      expect(response).to redirect_to admin_brands_path
    end
  end

  describe "GET edit" do
    it "assign brand" do
      brand = create(:brand)

      get :edit , params: { id: brand.id }

      expect(assigns[:brand]).to eq(brand)
    end

    it "render template" do
      brand = create(:brand)

      get :edit , params: { id: brand.id }

      expect(response).to render_template("edit")
    end
  end

  describe "PUT update" do
    it "assign @brand" do
      brand = create(:brand)
      params = {
        id: brand.id,
        brand: {
          name: Faker::Name.unique.name
        }
      }

      put :update , params: params

      expect(assigns[:brand]).to eq(brand)
    end

    it "changes value" do
      brand = create(:brand)
      new_name = Faker::Name.unique.name
      params = {
        id: brand.id,
        brand: {
          name: new_name
        }
      }

      put :update , params: params

      expect(assigns[:brand].name).to eq(new_name)
    end

    it "redirects to brand_path" do
      brand = create(:brand)
      params = {
        id: brand.id,
        brand: {
          name: Faker::Name.unique.name
        }
      }

      put :update , params: params

      expect(response).to redirect_to admin_brands_path
    end
  end

  describe "DELETE destroy" do
    it "assigns @brand" do
      brand = create(:brand)

      delete :destroy, params: { id: brand.id }

      expect(assigns[:brand]).to eq(brand)
    end

    it "deletes a record" do
      brand = create(:brand)

      expect {
        delete :destroy, params: { id: brand.id }
      }.to change { Brand.count }.by(-1)
    end

    it "redirects to brands_path" do
      brand = create(:brand)

      delete :destroy, params: { id: brand.id }

      expect(response).to redirect_to admin_brands_path
    end
  end
end
