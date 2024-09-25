ActiveAdmin.register User do
  # Permitting parameters
  permit_params :email, :name, :password, :password_confirmation

  # Customizing the form
  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :name
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  # Displaying relevant information in the index view
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :created_at
    actions
  end

  # Displaying relevant information in the show view
  show do
    attributes_table do
      row :email
      row :name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
end
