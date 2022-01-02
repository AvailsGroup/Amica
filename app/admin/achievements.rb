ActiveAdmin.register Achievement do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :niceLv1, :niceLv2, :niceLv3, :hand_like, :wink_like, :debugger
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :niceLv1, :niceLv2, :niceLv3, :hand_like, :wink_like, :debugger]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params { Achievement.attribute_names.map(&:to_sym) }
end
