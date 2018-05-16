class Client::RecipesController < ApplicationController
  def index
    response = Unirest.get("http://localhost:3000/api/recipes")
    @recipes = response.body
    render 'index.html.erb'
  end

  def new
  render 'new.html.erb' 
  end

  def create
    client_params = {title: params[:title],
                        chef: params[:chef],
                        ingredients: params[:ingredients],
                        directions: params[:directions],
                        prep_time: params[:prep_time]
                    }
    response = Unirest.post(
                            "http://localhost3000/api/recipes", client_params
                            ) 
    recipe = response.body
    flash[:success] = "Successfully created recipe"
    redirect_to "/client/recipes/#{ recipe["id"] }"                          
  end

  def show
    recipe_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/recipes/#{recipe_id}")
    @recipe = response.body
    @additional_message = "you made it to show"
    render 'show.html.erb'
   end 

   def edit
    recipe_id = params[:id]
    response = Unirest.get("ht tp://localhost:3000/api/recipes/#{recipe_id}")
    @recipe = response.body
    render 'edit.html.erb'
   end

   def update
    client_params = {
                      title: params[:title],
                        chef: params[:chef],
                        ingredients: params[:ingredients],
                        directions: params[:directions],
                        prep_time: params[:prep_time]
                      }
    response = Unirest.patch("http://localhost:3000/api/recipes/#{params[:id] }",parameters: client_params
                        )
    recipe = response.body
    flash[:success] = "Successfully Updated Recipe"
    redirect_to "/client/recipes/#{ recipe["id"] }"                  
   end

   def destroy
    recipe_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/recipes/#{ recipe_id }")
    flash[:success] = "Successfully destroyed recipe"
    redirect_to "/"
   end 
end
