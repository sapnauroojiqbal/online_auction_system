# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

begin
  user = User.new
  user.first_name = 'Admin'
  user.last_name = 'User'
  user.email = 'sapna.iqbal@devsinc.com'
  user.password = 'admin1234'
  user.password_confirmation = 'admin1234'
  user.user_type = :super_admin
  user.address = "Lahore , Pakistan"
  user.gender = 'male'
  user.phone_number = "0000-0000000"
  user.avatar.attach(io: File.open(Rails.root.join(*%w[app assets images default_profile.png])),
  filename: 'default_image.png', content_type: 'image/png')
  user.save!
rescue ActiveRecord::RecordInvalid => invalid
  puts invalid.record.errors.full_messages
end
