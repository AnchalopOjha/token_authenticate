ActiveAdmin.register Post do
 
  permit_params :title, :content, :user_id, images: []

  form do |f|
    f.inputs 'Post Details' do
      f.input :user, as: :select, collection: User.all.pluck(:email, :id) 
      f.input :title
      f.input :content
      f.input :images, as: :file, input_html: { multiple: true } 
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :user
    column :image do |post|
      if post.images.attached?
        image_tag url_for(post.images.first), size: "50x50" # Adjust size as necessary
      end
    end
    actions
  end


  show do
    attributes_table do
      row :title
      row :content
      row :user
      row :created_at
      row :updated_at


      row :images do |post|
        ul do
          post.images.each do |image|
            li do
              image_tag url_for(image) 
            end
          end
        end
      end
    end
  end

  filter :title
  filter :content
  filter :user
  filter :created_at
end
