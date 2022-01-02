ActiveAdmin.register Profile do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :grade, :school_class, :number, :student_id, :user_id, :birthday, :twitter_id, :enrolled_year, :intro, :instagram_id, :discord_name, :discord_tag
  #
  # or
  #
  # permit_params do
  #   permitted = [:grade, :school_class, :number, :student_id, :user_id, :birthday, :twitter_id, :enrolled_year, :intro, :instagram_id, :discord_name, :discord_tag]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params { Profile.attribute_names.map(&:to_sym) }
end
