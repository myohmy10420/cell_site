module Api
  module V1
    module Excel
      class VariantsController < Api::V1::Excel::BaseController
        def export
          @variants = get_variants

          respond_to do |format|
            format.xlsx {
              headers["Content-Disposition"] = "attachment; filename=方案.xlsx"
            }
          end
        end

        def import
          require 'roo'

          if !params[:file]
            flash[:alert] = "請選擇檔案"
          else
            @excel_import_errors = ""

            excel_page = Roo::Excelx.new(params[:file].path)
            excel_page.drop(1).each do |row|
              find_telecommunication(row)
              next if @telecommunication.nil?

              variant_params = build_params_by(row)

              find_variant(row)
              if @variant.present?
                next if @variant.update(variant_params)
                add_error(@variant)
              else
                new_variant = Variant.new(variant_params)
                next if new_variant.save
                add_error(new_variant)
              end
            end

            if @excel_import_errors.presence
              @excel_import_errors = @excel_import_errors.html_safe
            else
              flash[:notice] = "匯入成功！"
            end
          end

          @variants = get_variants

          render "admin/variants/index"
        end

        private

        def get_variants
          Variant.all.order('updated_at DESC')
        end

        def find_telecommunication(row)
          @telecommunication = Telecommunication.find_by(name: row[1].to_s)
          return if @telecommunication.presence
          add_error_telecommunication_not_found(row)
        end

        def find_variant(row)
          @variant = Variant.find_by(id: row[0])
        end

        def add_error_telecommunication_not_found(row)
          @excel_import_errors += row[2].to_s + "找不到" + row[1].to_s + "電信<br>"
        end

        def add_error(variant)
          name = variant.name || 'Unknow'
          tele_name = @telecommunication.name
          @excel_import_errors += tele_name + ' 的 ' + name + variant.errors.full_messages.join(", ") + "<br>"
        end

        def build_params_by(row)
          ActionController::Parameters.new({
            variant: {
              telecommunication_id: @telecommunication.id,
              name: row[2],
              content: row[3],
              content2: row[4],
              discount: row[5].to_i,
              prepaid: row[6].to_i,
              traffic: row[7],
              period: row[8],
              enable: row[9] == 'O' ? true : false
            }
          }).require(:variant).permit(:telecommunication_id, :name, :discount, :prepaid, :traffic, :period, :content, :content2, :enable)
        end
      end
    end
  end
end
