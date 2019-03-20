class OrderMailer < ApplicationMailer
  def complete_email(user, order)
    @user = user
    @order = order
    mail(to: @user.email, subject: I18n.t('mailers.order_mailer.subject', order_number: @order.id))
  end
end
