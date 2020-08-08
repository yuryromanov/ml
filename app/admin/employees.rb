ActiveAdmin.register Employee do
  permit_params :first_name, :last_name, :email

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :department
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :department

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :department
    end
    f.actions
  end
end
