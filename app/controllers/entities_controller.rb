class EntitiesController < ApplicationController

  def create
    new_ent = Entity.create(type: params[:type])
    session[:user] = new_ent
    redirect_to root_path
  end
end
