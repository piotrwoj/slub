class ReservationNotifier < ApplicationMailer

  default to: ENV["RESERVATION_NOTIFIER_TO"]

  def reserved(reservation)
    @reservation = reservation
    mail subject: "Zarezerwowano książkę"
  end

  def cancelled(reservation)
    @reservation = reservation
    mail subject: "Anulowano rezerwację książki"
  end
end
