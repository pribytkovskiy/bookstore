describe ReportWorker, type: :worker do
  let(:user) { create(:user, :with_orders_address) }
  let(:order) { user.orders.first }

  it 'should call OrderMailer' do
    delivery = double
    expect(delivery).to receive(:deliver_now).with(no_args)
    expect(OrderMailer).to receive(:complete_email).and_return(delivery)

    subject.perform(user, order)
  end
end
