require 'faraday'
require 'json'
require 'pp'

TOKEN = '965fa17681f52fb6db48d5aeb0a96689'

conn = Faraday.new

projects_response = conn.get 'https://www.pivotaltracker.com/services/v5/projects' do |request|
  request.headers['Content-Type'] = 'application/json'
  request.headers['X-TrackerToken'] = TOKEN
end

project_data = JSON.parse(projects_response.body)

puts "LIST OF ALL OF MY TRACKER PROJECTS:"
project_data.map {|project| puts "--" + project["name"]}


stories_response = conn.get 'https://www.pivotaltracker.com/services/v5/projects/1069192/stories' do |request|
  request.headers['Content-Type'] = 'application/json'
  request.headers['X-TrackerToken'] = TOKEN
end

stories_data =  JSON.parse(stories_response.body)

puts "LIST OF ALL THE STORIES IN THE QUIET-WATER-CRUD PROJECT"
stories_data.map {|story| puts "--" + story["name"]}


story_details_response = conn.get 'https://www.pivotaltracker.com/services/v5/projects/1069192/stories/70291036' do |request|
  request.headers['Content-Type'] = 'application/json'
  request.headers['X-TrackerToken'] = TOKEN
end

story_details_data =  JSON.parse(story_details_response.body)

puts "DESCRIPTION OF STORY ID 70291036 IN THE QUIET-WATER-CRUD PROJECT"
puts story_details_data["description"]