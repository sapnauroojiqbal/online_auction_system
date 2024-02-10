# frozen_string_literal: true

begin
  user = User.new
  user.first_name = 'Admin'
  user.last_name = 'User'
  user.email = 'sapna.iqbal@devsinc.com'
  user.password = 'admin1234'
  user.password_confirmation = 'admin1234'
  user.user_type = :super_admin
  user.address = 'Lahore , Pakistan'
  user.gender = 'male'
  user.phone_number = '0000-0000000'
  user.avatar.attach(io: File.open(Rails.root.join(*%w[app assets images default_profile.png])),
                     filename: 'default_image.png', content_type: 'image/png')
  user.save!
rescue ActiveRecord::RecordInvalid => e
  Rails.logger.debug e.record.errors.full_messages
end
