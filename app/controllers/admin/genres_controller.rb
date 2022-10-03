class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all.order("created_at DESC")
    @genre = Genre.new

  end


  def create
    @genre = Genre.new(genre_params)
    @genre.save!
       flash[:notice] = "Genre was successfully created"
       redirect_to admin_genres_path#(@genre.id)
   #else
      #@genres = Genre.all
       #render :index
   #end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
     @genre = Genre.find(params[:id])
     @genre.update (genre_params)
     redirect_to admin_genres_path, notice: 'Genre information updated successfully'
    #else
     #if @genre.update(genre_params)
      #  redirect_to _path(@genres.id)
     #else
    #render :edit , status: :unprocessable_entity
    #end
   #end
  end

  private

 def genre_params
  params.require(:genre).permit(:name)
 end
end
