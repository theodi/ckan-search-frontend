require 'sinatra'
require 'ckan'
require 'yaml'
require 'csv'

CKAN::API.api_url = "https://data.gov.uk/api/2/"

get '/' do
  erb :index
end

get '/:query' do
  @packages = CKAN::Package.find(q: params['query'])
  
  @all_entities = @packages.map do |package| 
    extra_data = YAML.load_file("data/#{package.name}.yml") rescue {}
    extra_data["entities"] || []
  end
  @all_entities.flatten!
  
  @entity_groups = {}
  @all_entities.uniq.each do |e|
    @entity_groups[e] = @all_entities.count(e)
  end
  
  erb :results
end
  
