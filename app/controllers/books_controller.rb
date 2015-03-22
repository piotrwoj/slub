# -*- encoding : utf-8 -*-

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :make_reservation, :cancel_reservation]
  skip_before_filter :authorize, only: [:index, :show, :make_reservation, :cancel_reservation]

  # GET /books
  # GET /books.json
  def index
    @books = Book.order(:title).includes(:reservations).all
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
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to books_url, notice: "Książka \"#{@book.title}\" została zapisana" }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to books_url, notice: "Książka \"#{@book.title}\" została zaktualizowana." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: "Ksiażka \"#{@book.title}\" została usunięta." }
      format.json { head :no_content }
      format.js {render js: "$('#tr#{@book.id}').fadeOut();"}
    end
  end

  def make_reservation
    @book.with_lock do
      if @book.reserved?
        render js: "alert('Ta książka została już zarezerwowana!')"
      else
        if (reservation = @book.reservations.create(ip: request.ip))
          if session[:reservation_ids].blank?
            session[:reservation_ids] = [reservation.id]
          else
            session[:reservation_ids] << reservation.id
          end
          render js: "$('#make_reservation_button_#{@book.id}').hide(); $('#cancel_reservation_button_#{@book.id}').show();"
        else
          render js: "alert('Rezerwacja nie powiodła się!')"
        end
      end
    end
  end

  def cancel_reservation
    @book.with_lock do
      if !@book.reserved?
        render js: "alert('Ta książka nie jest rarezerwowana!')"
      elsif !@book.my?(session)
        render js: "alert('Nie możesz anulować nie swojej rezerwacji!')"
      else
        if @book.reservations.find{|r| session[:reservation_ids].include?(r.id) && !r.canceled}.update_attribute(:canceled, true)
          render js: "$('#make_reservation_button_#{@book.id}').show(); $('#cancel_reservation_button_#{@book.id}').hide();"
        else
          render js: "alert('Anulowanie rezerwacji nie powiodło się!')"
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
      params.require(:book).permit(:title, :description, :reserved, :author)
    end
end
