json.array!(@books) do |book|
  json.extract! book, :id, :title, :description, :reserved, :author
  json.url book_url(book, format: :json)
end
