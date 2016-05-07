ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'

require_relative 'server'
require_relative 'data_mapper_setup'


class Chitter < Sinatra::Base

  get '/' do
    redirect '/user/new'
  end

  get '/user/new' do
    erb :'user/new'
  end

  post '/user/new' do
    user = User.create(name: params[:name],
                       user_name: params[:user_name],
                       email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect '/'
    else
      flash.now[:errors] = user.errors.full_messages
      erb :'user/new'
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end