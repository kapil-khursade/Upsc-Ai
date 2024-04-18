ActiveAdmin.setup do |config|
  config.site_title = "UPSC AI"
  config.site_title_image = "/upscailogoshot.png"
  config.footer = "UPSC AI v0.1"
  config.authentication_method = :authenticate_admin_user!
  config.authorization_adapter = ActiveAdmin::CanCanAdapter
  config.current_user_method = :current_admin_user
  config.logout_link_path = :destroy_admin_user_session_path
  config.batch_actions = true
  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
  config.comments = false

  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
  config.register_stylesheet "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css"
  config.register_javascript "https://canvasjs.com/assets/script/jquery.canvasjs.min.js"

  config.register_stylesheet "https://cdnjs.cloudflare.com/ajax/libs/noty/3.1.4/noty.min.css"
  config.register_javascript "https://cdnjs.cloudflare.com/ajax/libs/noty/3.1.4/noty.min.js"
  # config.register_stylesheet "/boostrap_invi.css"

  config.register_javascript "https://cdn.datatables.net/1.10.25/js/jquery.dataTables.min.js"
  config.register_stylesheet "https://cdn.datatables.net/1.10.25/css/jquery.dataTables.min.css"

end
