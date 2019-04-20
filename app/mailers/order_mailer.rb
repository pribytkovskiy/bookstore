class OrderMailer < ApplicationMailer
  def complete_email(user_email, order_id)
    mail(to: user_email, subject: I18n.t('mailers.order_mailer.subject', order_number: order_id))
  end
end
