# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "creating users"
User.create!(email:"royce@taskete.co", first_name:"Royce", last_name:"Lim", password:"123123")
User.create!(email:"daniel@taskete.co", first_name:"Daniel", last_name:"Teo", password:"123123")
User.create!(email:"ethan@taskete.co", first_name:"Ethan", last_name:"Pay", password:"123123")
User.create!(email:"prima@taskete.co", first_name:"Prima", last_name:"Aulia", password:"123123")
User.create!(email:"ashley@taskete.co", first_name:"Ashley", last_name:"Yeo", password:"123123")
User.create!(email:"jianzhen@taskete.co", first_name:"Jian", last_name:"Zhen", password:"123123")
User.create!(email:"miguel@taskete.co", first_name:"Miguel", last_name:"Jimenez", password:"123123")

royce = User.find_by(email:"royce@taskete.co")
daniel = User.find_by(email:"daniel@taskete.co")
ethan = User.find_by(email:"ethan@taskete.co")
prima = User.find_by(email:"prima@taskete.co")
ashley = User.find_by(email:"ashley@taskete.co")
jian = User.find_by(email:"jian@taskete.co")
miguel = User.find_by(email:"miguel@taskete.co")

puts "generating workflow hire"
workflow_hire = Workflow.new(title:"Hiring new employee")
workflow_hire.creator = ethan
workflow_hire.save
Task.create!(title:"Interview", completed: "true", workflow_id: workflow_hire.id)
Task.create!(title:"Make offer", completed: "true", workflow_id: workflow_hire.id)
task_hire = Task.create!(title:"Prepare onboarding", description: "Daniel has accepted the offer", completed: "current", workflow_id: workflow_hire.id)
Item.create!(title:"Prepare a macbook pro (max-spec)", task_id: task_hire.id)
royce.tasks << task_hire
workflow_hire.activate

puts "generating workflow birthday"
workflow_birthday = Workflow.new(title:"Birthday celebration for October")
workflow_birthday.creator = royce
workflow_birthday.save
Task.create!(title:"Get the list of employees having birthday this month", completed: "true", workflow_id: workflow_birthday.id)
Task.create!(title:"Set a date", workflow_id: workflow_birthday.id)
Task.create!(title:"Buy cake", description: "Budget is $60", workflow_id: workflow_birthday.id)
workflow_birthday.activate

puts "generating workflow payroll"
workflow_payroll = Workflow.new(title:"Payroll")
workflow_payroll.creator = royce
workflow_payroll.save
Task.create!(title:"Make payroll changes by cutoff date", workflow_id: workflow_payroll.id)
Task.create!(title:"Prepare payroll report and get finance approval", workflow_id: workflow_payroll.id)
Task.create!(title:"Contribute to CPF", workflow_id: workflow_payroll.id)
task_payroll = Task.create!(title:"Send documents to employees", description: "Budget is $60", workflow_id: workflow_payroll.id)
Item.create!(title:"Send payslip", task_id: task_payroll.id)
Item.create!(title:"Send promotion letter", task_id: task_payroll.id)

puts "generating workflow performance review"
workflow_performance = Workflow.new(title:"Performance review for Ashley")
workflow_performance.creator = royce
workflow_performance.save
Task.create!(title:"Complete performance review template", completed: "true", workflow_id: workflow_performance.id)
task_performance = Task.create!(title:"Set up review session with hr", completed: "current", workflow_id: workflow_performance.id)
Task.create!(title:"Management approval", workflow_id: workflow_performance.id)
Task.create!(title:"Communicate to employee", workflow_id: workflow_performance.id)
royce.tasks << task_performance
miguel.tasks << task_performance
ashley.tasks << task_performance
workflow_performance.activate

puts "generating workflow offboard"
workflow_offboarding = Workflow.new(title:"Offboarding")
workflow_offboarding.creator = royce
workflow_offboarding.save
Task.create!(title:"Inform relevant stakeholders", workflow_id: workflow_offboarding.id)
Task.create!(title:"Conduct exit interview", workflow_id: workflow_offboarding.id)
Task.create!(title:"Announce to the team", workflow_id: workflow_offboarding.id)
Task.create!(title:"Send final salary", workflow_id: workflow_offboarding.id)
task_offboarding = Task.create!(title:"Collect company assets", workflow_id: workflow_offboarding.id)
Item.create!(title:"Collect office access card", task_id: task_offboarding.id)
Item.create!(title:"Collect company laptop", task_id: task_offboarding.id)


puts "generating workflow onboard"
workflow_onboarding = Workflow.new(title:"Onboarding")
workflow_onboarding.creator = royce
workflow_onboarding.save
task_onboarding1 = Task.create!(title:"Prepare equipment", workflow_id: workflow_onboarding.id)
task_onboarding2 = Task.create!(title:"Equipment and account setup", workflow_id: workflow_onboarding.id)
task_onboarding3 = Task.create!(title:"Manager onboarding", workflow_id: workflow_onboarding.id)
task_onboarding4 = Task.create!(title:"Technical setup for SWE", workflow_id: workflow_onboarding.id)
task_onboarding5 = Task.create!(title:"HR onboarding", workflow_id: workflow_onboarding.id)
Item.create!(title:"Assign office access card", task_id: task_onboarding1.id)
Item.create!(title:"Company swag", task_id: task_onboarding1.id)
royce.tasks << task_onboarding1
Item.create!(title:"Setup laptop", task_id: task_onboarding2.id)
Item.create!(title:"Setup email", task_id: task_onboarding2.id)
Item.create!(title:"Setup Slack", task_id: task_onboarding2.id)
Item.create!(title:"Setup Zoom", task_id: task_onboarding2.id)
Item.create!(title:"Fill up employee information", description: "Full legal name: \nNRIC/FIN: \n:Birthday:", task_id: task_onboarding2.id)
Item.create!(title:"Day 1 brief", task_id: task_onboarding3.id)
Item.create!(title:"Introduce new hire to the team", task_id: task_onboarding3.id)
Item.create!(title:"Give github access", task_id: task_onboarding4.id)
Item.create!(title:"Company culture", task_id: task_onboarding5.id)
Item.create!(title:"Company policies", task_id: task_onboarding5.id)
