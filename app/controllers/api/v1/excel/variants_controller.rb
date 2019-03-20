module Api
  module V1
    module Excel
      class VariantsController < ApplicationController
        def export
          @variants = Variant.all.order('updated_at DESC')

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=方案.xlsx"
            }
          end
        end

        def import
          require 'roo'

          workbook = Roo::Excelx.new(params[:file].path) if params[:file]
          workbook.drop(1).each do |row|
            telecommunication = Telecommunication.find_by(name: row[0])
            params = ActionController::Parameters.new({
              variant: {
                telecommunication_id: telecommunication.id,
                name: row[1],
                content: row[2],
                discount: row[3].to_i,
                prepaid: row[4].to_i,
                traffic: row[5],
                period: row[6]
              }
            })
            variant_params = params.require(:variant).permit(:telecommunication_id, :name, :discount, :prepaid, :traffic, :period, :content)

            variant = Variant.find_by(name: row[1])
            if variant.present?
              variant.update(variant_params)
            else
              Variant.create(variant_params)
            end
          end if workbook

          redirect_to admin_variants_path
        end
      end
    end
  end
end
