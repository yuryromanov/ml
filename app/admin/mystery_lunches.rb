ActiveAdmin.register MysteryLunch do
  belongs_to :lunch_date
  actions :index

  filter :lunch_partners_employee_department_id, label: 'Department', as: :select, collection: -> { Department.all.map{|x| [x.name, x.id]} }

  config.sort_order = 'id asc'

  index do
    column :id
    column :name do |mystery_lunch|
      table_for(mystery_lunch.lunch_partners) do
        column :id do |lunch_partner|
          lunch_partner.employee.id
        end
        column :name do |lunch_partner|
          lunch_partner.employee.name
        end
        column :email do |lunch_partner|
          lunch_partner.employee.email
        end
        column :department do |lunch_partner|
          lunch_partner.employee.department.name
        end
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
