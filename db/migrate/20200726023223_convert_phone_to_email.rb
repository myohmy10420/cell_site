class ConvertPhoneToEmail < ActiveRecord::Migration[5.2]
  def change
    users = User.all
    users.each do |u|
      u.update_column(:email, "#{u.phone}@jspe.com") if u.email.blank?
    end
  end
end
