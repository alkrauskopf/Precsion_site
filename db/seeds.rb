# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
bacon_ipsum = <<END
Bacon ipsum dolor amet voluptate short ribs tri-tip, cillum flank enim mollit excepteur in et anim cow boudin deserunt chuck. Excepteur doner magna tri-tip porchetta et commodo exercitation strip steak in cupim. Proident ut irure aute laborum exercitation. Non lorem biltong jowl. Cow aliqua tri-tip excepteur beef ribs.

Fatback corned beef in nisi alcatra. Filet mignon eiusmod capicola, pork belly nulla voluptate chicken veniam brisket. Pork belly ex filet mignon, consectetur cillum jowl occaecat sirloin flank officia velit ham fatback laboris. Nulla esse brisket commodo pork loin tongue short ribs swine shoulder proident veniam ullamco. Brisket salami reprehenderit deserunt spare ribs beef ribs laborum flank drumstick labore dolore in. Andouille labore do tempor hamburger esse sausage.

Incididunt prosciutto minim est, in sed dolor culpa. Laborum tenderloin andouille, ground round qui aute consequat occaecat est. Cillum picanha nisi voluptate beef ribs, aliqua hamburger boudin jowl kevin. Jerky consequat t-bone, non turducken minim flank. Dolor reprehenderit dolore short loin, prosciutto sint t-bone. Cow eiusmod spare ribs ball tip.

Kielbasa tri-tip jerky, meatloaf mollit eiusmod t-bone in consectetur turducken cupim veniam esse strip steak. Leberkas spare ribs lorem meatloaf anim. Strip steak fugiat short loin, tri-tip ball tip est andouille. Spare ribs velit ullamco esse enim nulla pork brisket incididunt t-bone pork loin dolore cow beef ribs. Tempor jowl meatloaf, pork loin deserunt t-bone beef pork prosciutto. Ham venison mollit, cillum corned beef turducken meatloaf deserunt dolore aliqua esse in dolore ullamco eu. Landjaeger occaecat ham, drumstick sint qui tenderloin corned beef shoulder biltong.

Spare ribs dolor laborum meatball ex ribeye tri-tip. Ut corned beef andouille ball tip culpa laborum labore jowl. Quis porchetta non commodo est dolor. Meatloaf veniam elit, ham in beef jerky exercitation pastrami shankle. Turducken nostrud corned beef bresaola alcatra, sint dolore kevin consectetur ipsum shoulder capicola ad spare ribs. Veniam beef ribs nisi commodo hamburger short loin.
END
samuel_ipsum = <<END
Yeah, I like animals better than people sometimes... Especially dogs. Dogs are the best. Every time you come home, they act like they haven't seen you in a year. And the good thing about dogs... is they got different dogs for different people. Like pit bulls. The dog of dogs. Pit bull can be the right man's best friend... or the wrong man's worst enemy. You going to give me a dog for a pet, give me a pit bull. Give me... Raoul. Right, Omar? Give me Raoul.

The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men. Blessed is he who, in the name of charity and good will, shepherds the weak through the valley of darkness, for he is truly his brother's keeper and the finder of lost children. And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.

Well, the way they make shows is, they make one show. That show's called a pilot. Then they show that show to the people who make shows, and on the strength of that one show they decide if they're going to make more shows. Some pilots get picked and become television programs. Some don't, become nothing. She starred in one of the ones that became nothing.

Your bones don't break, mine do. That's clear. Your cells react to bacteria and viruses differently than mine. You don't get sick, I do.
That's also clear. But for some reason, you and I react the exact same way to water. We swallow it too fast, we choke. We get some in our lungs, we drown.
However unreal it may seem, we are connected, you and I. We're on the same curve, just on opposite ends.
END
# User Roles
Authorization.destroy_all
Authorization.create(id: 1, name: 'admin', long_name: 'System Administrator')
Authorization.create(id: 2, name: 'team', long_name: 'Core Team Member')
#

#  User Classes
UserClass.destroy_all
UserClass.create(id: 1, abbrev: 'core', name: 'Core Team', description: 'Core Team Member')
UserClass.create(id: 2, abbrev: 'consult', name: 'Exended Team', description: 'Extended Team Member')
#

# Offerings
Offering.destroy_all
Offering.create(id: 1, name: 'Performance Monitoring', brief: 'Diagnostics, action plans, progress monitoring', description: bacon_ipsum)
Offering.create(id: 2, name: 'Observation', brief: 'Classroom observation tools', description: samuel_ipsum)
Offering.create(id: 3, name: 'Assessment', brief: 'Assessment tools', description: samuel_ipsum)
Offering.create(id: 4, name: 'Class Offerings', brief: 'Topic Areas, i.e. subjects of study.', description: bacon_ipsum)
Offering.create(id: 5, name: 'Professional Development', brief: 'Teacher development tools, networks, and opportunities.', description: bacon_ipsum)
#
