class WelcomeController < ApplicationController

  def index
    @names = []
    @pics = []
    @titles = []
    @bios = []
    @names[0] = 'Dr. Mary Lindimore'
    @pics[0] = 'lindimore.jpg'
    @titles[0] = 'Founder & Managing Partner'
    @bios[0] = 'Dr. Mary Lindimore, Precision School Improvement Network Colorado State Director.  Dr. Lindimore oversees all school  and district contracts, provides supports to diagnostic review teams and improvement planning processes in schools. Mary is a former Middle and High School principal.  Mary previously served as the State Director of School and District Support in Colorado for the National Center on Time & Learning.'
    @names[1] = 'Dr. Carol Sorvig'
    @pics[1] = 'sorvig.jpg'
    @titles[1] = 'Advisor'
    @bios[1] = 'Dr. Carol Sorvig, School Diagnostic Review and Improvement Planning Team Member.  Dr. Carol Sorvig Retired Elementary Principal and SPED specialist for Precision.  She provides leadership to the diagnostic review team and is the primary support source for the improvement planning process.'
    @names[2] = 'Dr. Karen Taylor'
    @pics[2] = 'taylor.jpg'
    @titles[2] = 'Advisor'
    @bios[2] = "Dr. Karen Taylor, School Diagnostic Review and Improvement Planning Team Member. Karen is a Retired MSU Affiliate Professor for the Teacher Preparation Program and a Retired High School Principal Alternative Education.  Karen's area of expertise for Precision is in teacher effectiveness.  Karen spent two years working on the LEAP framework as a peer observer for teacher in vocational education."
    @names[3] = 'Ms. Jill Colby'
    @pics[3] = 'colby.jpg'
    @titles[3] = 'Advisor'
    @bios[3] = "Jill Colby, Precision's School Diagnostic Review and Improvement Planning Team Member.  Jill is a Retired Middle and High School Principal.  Jill's expertise is in building effective school schedules, special education."
    @names[4] = 'Ms. Paula Redig'
    @pics[4] = 'colby.jpg'
    @titles[4] = 'Advisor'
    @bios[4] = "bio needed"
    @names[5] = 'Ms. Lisa Pryor'
    @pics[5] = 'pryor.jpg'
    @titles[5] = 'Advisor'
    @bios[5] = "Lisa Pryor, Precision Consultant, NCTL Managing Director for the National Center on Time & Learning, Former Assistant Commissioner of Education, OK."
    @names[6] = 'Ms. Patricia Stazko'
    @pics[6] = 'staszko.jpg'
    @titles[6] = 'SPED Advisor'
    @bios[6] = " Pat Staszko is a SPED Consultant for Precision, ensuring that recommendations for interventions are best practice and cutting edge."
    @names[7] = 'Allen Krauskopf'
    @pics[7] = 'krauskopf.jpg'
    @titles[7] = 'Managing Partner'
    @bios[7] = "A formaer Associate Partner with PricewaterhouseCoopers Management Consulting, Allen specializes in business transformation, quality management, and technology strategy. Allen provides the technology infrastructure that aligns Precision's methods with proven transformation tenets."
  end
end
