RSpec.describe Admin::BrandsController, type: :controller do
  before do
    sign_in(FactoryBot.create(:admin_user))
  end

  describe "GET index" do
    it "assigns @brands" do
      brand1 = FactoryBot.create(:brand)
      brand2 = FactoryBot.create(:brand)

      get :index

      expect(assigns[:brands]).to eq([brand1, brand2])
    end

    it "render template" do
      get :index

      expect(response).to render_template("index")
    end
  end
end
