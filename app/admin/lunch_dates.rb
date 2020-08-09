ActiveAdmin.register LunchDate do
  permit_params :date
  actions :index, :edit, :update

  index do
    column :id
    column :date do |mystery_date|
      link_to(
        mystery_date.date,
        admin_lunch_date_mystery_lunches_path(
          lunch_date_id: mystery_date.id
        ),
        class: 'member_link view_link')
    end
  end

  filter :date

  collection_action :upcoming do
    redirect_to(admin_lunch_date_mystery_lunches_path(lunch_date_id: LunchDate.upcoming.first.id))
  end
end
