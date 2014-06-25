# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'
require 'populator'

User.destroy_all

10.times do
    user = User.new
    user.name = Faker::Name.name
    user.username = Faker::Internet.user_name
    user.email = Faker::Internet.email
    user.password = "test1234"
    user.password_confirmation = "test1234"
    user.save
end

User.all.each do |user|
    Tweet.populate(5..10) do |tweet|
        tweet.user_id = user.id
        tweet.message = Faker::Lorem.sentence
    end
    
    3.times do
        user.follow(User.all[rand(User.count)])
        user.favorite(Tweet.all[rand(Tweet.count)])
	end
    
    # TODO add retweets
end
    
