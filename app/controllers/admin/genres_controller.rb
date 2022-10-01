class Admin::GenresController < ApplicationController
  def index
    @genre = Genre.new
    @genres = Genre.all
    @admin = current_admin
  end

  def new
     @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    @admin = @genre.admin
   if @genre.save
       flash[:notice] = "Genre was successfully created"
       redirect_to admin_genres_path(@genre)
   else
      @genres = Genre.all
       render :index
   end
  end

  def edit
  end

  def update
  end

  private

 def genre_params
  params.require(:genre).permit(:name)
 end
end
