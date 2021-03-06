class Books < Application
  # provides :xml, :yaml, :js

  def index
    @books = Book.all
    display @books
  end

  def show(id)
    @book = Book.get(id)
    raise NotFound unless @book
    display @book
  end

  def new
    only_provides :html
    @book = Book.new
    display @book
  end

  def edit(id)
    only_provides :html
    @book = Book.get(id)
    raise NotFound unless @book
    display @book
  end

  def create(book)
    @book = Book.new(book)
    if @book.save
      redirect resource(@book), :message => {:notice => "Book #{@book.name}was successfully created!"}
    else
      message[:error] = "Book failed to be created"
      render :new
    end
  end

  def update(id, book)
    @book = Book.get(id)
    raise NotFound unless @book
    if @book.update_attributes(book)
       redirect resource(@book), :message => {:notice =>"Book #{@book.name} was successfully updated!"}
    else
      display @book, :edit
    end
  end

  def destroy(id)
    @book = Book.get(id)
    raise NotFound unless @book
    if @book.destroy
      redirect resource(:books)
    else
      raise InternalServerError
    end
  end

end # Books
