ActiveAdmin.register User do
  menu parent: "Users", priority: 10

  actions :all

  permit_params :email,
  :first_name,
  :last_name,
  :notes,
  :archived,
  :roles,
  :zipcode,
  :test,
  :password

  scope :active, default: true
  scope :users
  scope :clients
  scope :admins
  scope :archived
  scope :test

  config.sort_order = "lower(last_name) asc, lower(first_name) asc"

  filter :first_name
  filter :last_name

  index do
    selectable_column
    id_column
    column :first_name
    column :last_name
    column :email do |user|
      mail_to user.email, user.email
    end
    column :roles do |user|
      user.roles.join(", ").capitalize
    end
    column :updated_at
    actions
  end

  form do |f|
    f.inputs "User" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :notes
      f.input :zipcode
      f.input :archived
      f.input :test
      # f.input :password, hint: "8 alphanumeric characters required"
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :roles
      row :email do |user|
        mail_to user.email, user.email
      end
      row :archived
      row :test
      row :created_at
      row :updated_at
    end

    panel "Favorites" do
      # if user.is?(Roles::TUTOR)
      #   table_for user.favorites.includes(:events) do |t|
      #     t.column "ID" do |tutor_assignment|
      #       tutor_assignment.id
      #     end
      #     t.column "Classroom ID" do |tutor_assignment|
      #       link_to tutor_assignment.classroom.id, admin_classroom_path(id: tutor_assignment.classroom.id)
      #     end
      #   end
      # end
    end
  end
end