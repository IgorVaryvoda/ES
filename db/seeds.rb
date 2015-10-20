# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# ruby encoding: utf-8

Author.create(
     first_name: 'Tom',
     last_name: 'Souer',
     discipline: 'English and Literature',
     description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
     raiting: 4.5,
     completed_orders: 43,
     avatar: 'authors/avatar_2.jpg')
Author.create(
     first_name: 'Michael',
     last_name: 'Werner',
     discipline: 'Business and Management',
     description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
     raiting: 3.5,
     completed_orders: 122,
     avatar: 'authors/avatar_1.jpg'
)
Author.create(
    first_name: 'Tim',
    last_name: 'Trable',
    discipline: 'Marketing',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 2.5,
    completed_orders: 105,
    avatar: 'authors/avatar_3.jpg'
)
Author.create(
    first_name: 'Lola',
    last_name: 'Henkey',
    discipline: 'Economics',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 5.0,
    completed_orders: 72,
    avatar: 'authors/avatar_4.jpg'
)
Author.create(
    first_name: 'Monica',
    last_name: 'Ramsey',
    discipline: 'History',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 1.5,
    completed_orders: 88,
    avatar: 'authors/avatar_5.jpg'
)
Author.create(
    first_name: 'Luisa',
    last_name: 'Bambert',
    discipline: 'Psychology and Education',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 0.5,
    completed_orders: 94,
    avatar: 'authors/avatar_6.jpg'
)
Author.create(
    first_name: 'Berndt',
    last_name: 'Shuster',
    discipline: 'Political science',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 1.0,
    completed_orders: 67,
    avatar: 'authors/avatar_2.jpg'
)
Author.create(
    first_name: 'Claus',
    last_name: 'Santa',
    discipline: 'Sociology',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 4.5,
    completed_orders: 67,
    avatar: 'authors/avatar_3.jpg'
)
Author.create(
    first_name: 'Arnold',
    last_name: 'Scwarz',
    discipline: 'Philosophy',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 4.5,
    completed_orders: 15,
    avatar: 'authors/avatar_1.jpg'
)
Author.create(
    first_name: 'Sara',
    last_name: 'Parker',
    discipline: 'Health Care and Life Sciences',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 3.0,
    completed_orders: 27,
    avatar: 'authors/avatar_5.jpg'
)
Author.create(
    first_name: 'Rebeka',
    last_name: 'Molnis',
    discipline: 'Computer science',
    description:'Note that this schema.rb definition is the authoritative source for your
database schema. If you need to create the application database on another',
    raiting: 2.0,
    completed_orders: 27,
    avatar: 'authors/avatar_6.jpg'
)

Rate.create(
    level: 'undergraduate',
    time: '12 hours',
    rate: 2.6
)
Rate.create(
    level: 'undergraduate',
    time: '24 hours',
    rate: 2.3
)
Rate.create(
    level: 'undergraduate',
    time: '2 days',
    rate: 2
)
Rate.create(
    level: 'undergraduate',
    time: '3 days',
    rate: 1.8
)
Rate.create(
    level: 'undergraduate',
    time: '6 days',
    rate: 1.6
)
Rate.create(
    level: 'undergraduate',
    time: '10 days',
    rate: 1.4
)
Rate.create(
    level: 'undergraduate',
    time: '14 days',
    rate: 1
)
Rate.create(
    level: 'bachelor',
    time: '12 hours',
    rate: 2.9
)
Rate.create(
    level: 'bachelor',
    time: '24 hours',
    rate: 2.7
)
Rate.create(
    level: 'bachelor',
    time: '2 days',
    rate: 2.5
)
Rate.create(
    level: 'bachelor',
    time: '3 days',
    rate: 2.3
)
Rate.create(
    level: 'bachelor',
    time: '6 days',
    rate: 2
)
Rate.create(
    level: 'bachelor',
    time: '10 days',
    rate: 1.8
)
Rate.create(
    level: 'bachelor',
    time: '14 days',
    rate: 1.6
)
Rate.create(
    level: 'professional',
    time: '12 hours',
    rate: 3.9
)
Rate.create(
    level: 'professional',
    time: '24 hours',
    rate: 3.5
)
Rate.create(
    level: 'professional',
    time: '2 days',
    rate: 3.1
)
Rate.create(
    level: 'professional',
    time: '3 days',
    rate: 2.8
)
Rate.create(
    level: 'professional',
    time: '6 days',
    rate: 2.4
)
Rate.create(
    level: 'professional',
    time: '10 days',
    rate: 2.1
)
Rate.create(
    level: 'professional',
    time: '14 days',
    rate: 1.9
)