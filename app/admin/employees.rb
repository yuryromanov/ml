ActiveAdmin.register Employee do
  permit_params :first_name, :last_name, :email, :department_id

  decorate_with EmployeeDecorator

  index do
    id_column
    column :gravatar do |employee|
      image_tag employee.gravatar_url(:rating => 'R', :secure => true, default: 'identicon')
    end
    column :email
    column :name
    column :department
    column :available_for_lunch
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
      f.input :department_id, as: :select, include_blank: false, collection: Department.all
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :id
      row :gravatar
      row :first_name
      row :last_name
      row :email
      row :department
      row :available_for_lunch
      row :created_at
      row :updated_at
    end
      mystery_lunches = MysteryLunch
        .joins(:lunch_partners, :lunch_date)
        .where(lunch_partners: { employee_id: employee.id })
        .includes(lunch_partners: {employee: :department})
        .order('lunch_dates.date': :desc)

      mystery_lunches.each do |mystery_lunch|
        panel("Mystery Lunch #{mystery_lunch.lunch_date.date}") do
          table_for(mystery_lunch.lunch_partners.decorate, label: 'ddd') do
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
    end

  controller do
    def create
      create! do |success,failure|
        success.html do
          LunchUpdater.new.join_existing_lunch(@employee)

          redirect_to collection_path
        end
        failure.html { render :edit }
      end
    end

    def destroy
      employee = Employee.find_by(id: params[:id])
      employee.update(available_for_lunch: false)

      LunchUpdater.new.rearrange_lunch(employee)

      redirect_to(admin_employees_path)
    end
  end
end
