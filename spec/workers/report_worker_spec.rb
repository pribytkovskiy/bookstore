describe ReportWorker, type: :worker do
  let(:user) { create(:user, :with_orders_address) }
  let(:order) { user.orders.first }
  let(:user_email) { user.email }
  let(:order_id) { user.id }

  it 'call OrderMailer' do
    delivery = double
    expect(delivery).to receive(:deliver_now).with(no_args)
    expect(OrderMailer).to receive(:complete_email).and_return(delivery)

    subject.perform(user_email, order_id)
  end
end
