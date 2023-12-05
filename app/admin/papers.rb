ActiveAdmin.register Paper do
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end
  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

end
