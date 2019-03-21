class ReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_email, order_id)
    OrderMailer.complete_email(user_email, order_id).deliver_later
  end
end
