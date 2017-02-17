# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
# User Roles
if false
  Authorization.destroy_all
  Authorization.create(name: 'admin', long_name: 'System Administrator')
  Authorization.create(name: 'team', long_name: 'Core Team Member')
  Authorization.create(name: 'prep', long_name: 'Precision Prep Admin')
end
#

#  User Classes
if false
  UserClass.destroy_all
  UserClass.create( abbrev: 'core', name: 'Core Team', description: 'Core Team Member')
  UserClass.create( abbrev: 'consult', name: 'Exended Team', description: 'Extended Team Member')
  UserClass.create(abbrev: 'prep', name: 'Prep Team', description: 'Precision Prep Team')
end
#

