class ReportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perfom(start_date, end_date)
    puts "Generatting a report from #{start_date} to #{end_date}"
  end
end

# ReportWorker.perform_async('1', '31')