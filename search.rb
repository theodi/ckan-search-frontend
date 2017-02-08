require 'sinatra'
require 'ckan'
require 'yaml'

CKAN::API.api_url = "https://data.gov.uk/api/2/"

get '/' do
  erb :index
end

get '/:query' do
  @packages = CKAN::Package.find(q: params['query'])
  erb :results
end
  
