ActiveAdmin.register MysteryLunch do
  belongs_to :lunch_date
  actions :index

  filter :lunch_partners_employee_department_id, label: 'Department', as: :select, collection: -> { Department.all.map{|x| [x.name, x.id]} }

  config.sort_order = 'id asc'

  index do
    column :id
    column do |mystery_lunch|
      table_for(mystery_lunch.lunch_partners.decorate) do
        column :id do |lunch_partner|
          link_to(lunch_partner.employee.id, admin_employee_path(lunch_partner.employee.id), :class => 'member_link view_link')
        end
        column :gravatar
        column :name
        column :email
        column :department
      end
    end
  end

  controller do
    def scoped_collection
      MysteryLunch
        .where(lunch_date_id: params[:lunch_date_id])
        .includes(lunch_partners: {employee: :department})
    end
  end

end
