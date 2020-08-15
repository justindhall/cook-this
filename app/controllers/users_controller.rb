class UsersController < ApplicationController
  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/recipes'
    end
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/recipes'
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect to '/recipes'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/recipes'
    else
      redirect to '/'
    end
  end

  get '/logout' do
    session.clear
    redirect to '/'
  end
end
