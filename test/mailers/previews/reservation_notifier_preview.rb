# Preview all emails at http://localhost:3000/rails/mailers/reservation_notifier
class ReservationNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reservation_notifier/reserved
  def reserved
    ReservationNotifier.reserved
  end

  # Preview this email at http://localhost:3000/rails/mailers/reservation_notifier/cancelled
  def cancelled
    ReservationNotifier.cancelled
  end

end
