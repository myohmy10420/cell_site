module Admin
  class CategoriesController < Admin::BaseController
    def destroy
      @category = Category.find(params[:id])
      brand = @category.brand
      @category.destroy
      flash[:notice] = "刪除子分類成功"

	    redirect_to edit_admin_brand_path(brand)
    end
  end
end
