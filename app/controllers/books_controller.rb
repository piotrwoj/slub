# -*- encoding : utf-8 -*-

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :make_reservation, :cancel_reservation]
  skip_before_filter :authorize, only: [:index, :show, :make_reservation, :cancel_reservation]

  # GET /books
  # GET /books.json
  def index
    @books = Book.order(:title).includes(:reservations)
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book.reserved = @book.reserved?
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_url, notice: "Książka \"#{@book.title}\" została zapisana"
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if @book.update(book_params)
      redirect_to books_url, notice: "Książka \"#{@book.title}\" została zaktualizowana."
    else
      render :edit
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Ksiażka \"#{@book.title}\" została usunięta." }
      format.js {render js: "$('#tr#{@book.id}').fadeOut();"}
    end
  end

  def make_reservation
    return render js: "alert('Zablokowano możliwość rezerwacji książek'); location.reload();" if Settings.reservations != 'on'
    if Book.get_my(session)
      return render js: "alert('Zarezerwowałeś już jedną książkę!'); location.reload();"
    end
    @book.with_lock do
      if @book.reserved?
        render js: "alert('Ta książka była już zarezerwowana!'); location.reload();"
      else
        if (reservation = @book.reservations.create(ip: request.ip))
          session[:reservation_id] = reservation.id
          #ReservationNotifier.reserved(reservation).deliver_now
          render js: "make_reservation(#{@book.id}, \"#{@book.title}\", \"#{@book.author}\")"
        else
          render js: "alert('Rezerwacja nie powiodła się!'); location.reload();"
        end
      end
    end
  end

  def cancel_reservation
    @book.with_lock do
      if !@book.reserved?
        render js: "alert('Ta książka nie jest rarezerwowana!'); location.reload();"
      elsif !@book.my?(session)
        render js: "alert('Nie możesz anulować nie swojej rezerwacji!'); location.reload();"
      else
        reservation = Reservation.where(id: session[:reservation_id], canceled: false).first
        if reservation && reservation.update_attribute(:canceled, true)
          session[:reservation_id] = nil
          #ReservationNotifier.cancelled(reservation).deliver_now
          render js: "cancel_reservation(#{@book.id})"
        else
          render js: "alert('Anulowanie rezerwacji nie powiodło się!'); location.reload();"
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.includes(:reservations).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :description, :reserved, :author, :hidden_note)
    end
end
