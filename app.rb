#!/usr/bin/env ruby

require 'dm-core'
require 'dm-timestamps'
require 'dm-validations'
require 'dm-migrations'

DataMapper.setup :default, "sqlite://#{Dir.pwd}/db/smartgym.db" 

class Users
  include DataMapper::Resource

  property :id,           Serial # Auto increment integer key
  property :user,         String, :required => true, :key => true, :unique_index => true
  property :pwd,          String, :required => true
  property :email,        String, format: :email_address
  property :dateCreated,  DateTime
end

DataMapper.auto_upgrade!
# DataMapper.auto_migrate!

get '/' do 
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  androidUser = params[:user]
  androidPwd = params[:pwd]

  if userData = Users.first(:user => androidUser)
    if userData.pwd == androidPwd
      redirect '/login/success'
      else
      redirect '/login/unsuccessful'
    end
  end

end

get '/register' do
  erb :register
end

post '/register' do
  user = params[:user]
  pwd = params[:pwd]
  email = params[:email]
  Users.create(user: user, pwd: pwd, email: email)
end