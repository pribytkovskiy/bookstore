class ReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user, order)
    OrderMailer.complete_email(user_email, order_id).deliver_later
  end
end
