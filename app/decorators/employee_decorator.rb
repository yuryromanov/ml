# app/decorators/article_decorator.rb
class EmployeeDecorator < Draper::Decorator
  include Gravtastic
  gravtastic
  delegate_all

  def name
    "#{first_name} #{last_name}"
  end

  def gravatar
    ActionController::Base.helpers.image_tag(gravatar_url(:rating => 'R', :secure => true, default: 'identicon'))
  end

  def department
    object.department.name
  end
end