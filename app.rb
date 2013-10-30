#!/usr/bin/env ruby
require 'sinatra'

get '/hello/:user' do
  "Hello #{params[:user]}!" 
end
