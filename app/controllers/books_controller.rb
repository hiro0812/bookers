class BooksController < ApplicationController
protect_from_forgery

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
     flash[:notice] = "Book was successfully created"
    # 4. トップ画面へリダイレクト
     redirect_to book_path(@book.id)
    else
    # flash[:alret] = "Book wasn't successfully created"
     @books = Book.all
     render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @books = Book.all
    @book = Book.find(params[:id])
  end

  def update
    # １.&2. データを受け取り更新するためのインスタンス作成
    @book = Book.find(params[:id])
    # 3. データをデータベースに更新するためのupdateメソッド実行
    if @book.update(book_params)
     flash[:notice] = "Book was successfully updated."
    # 4. Syow画面へリダイレクト
     redirect_to book_path(@book.id)
    else
    # flash[:alret] = "Book wasn't successfully updated."
     @books = Book.all
     render :edit
    end
  end

  def destroy
    # データ（レコード）を1件取得
    book = Book.find(params[:id])
    # データ（レコード）を削除
    book.destroy
    # 投稿一覧画面へリダイレクト
    redirect_to books_path
  end

    private
  # ストロングパラメータ
    def book_params
      params.require(:book).permit(:title, :body)
    end

end
