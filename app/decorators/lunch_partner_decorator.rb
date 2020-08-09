# app/decorators/article_decorator.rb
class LunchPartnerDecorator < Draper::Decorator
  decorates_association :employee
  delegate :gravatar, :name, :email, :department, to: :employee
end