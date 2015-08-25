# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#   User Roles
     Authorization.destroy_all
     Authorization.create(id: 1, name: 'admin', long_name: 'System Administrator')
     Authorization.create(id: 2, name: 'team', long_name: 'Core Team Member')
#
#   User Classes
UserClass.destroy_all
UserClass.create(id: 1, abbrev: 'core', name: 'Core Team', description: 'Core Team Member')
UserClass.create(id: 2, abbrev: 'consult', name: 'Exended Team', description: 'Extended Team Member')
#
