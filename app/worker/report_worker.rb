class ReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user, order)
    OrderMailer.complete_email(user, order).deliver_now
  end
end
