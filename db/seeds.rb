# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

puts "Seeding messages..."

subject_mapping = {
  "questionnaire.pending" => "Application Received",
  "questionnaire.accepted" => "You've been accepted!",
  "questionnaire.denied" => "Your application status",
  "questionnaire.rsvp_confirmed" => "RSVP Confirmation",
  "questionnaire.rsvp_reminder" => "Are you coming to #{HackathonConfig['name']}?",
  "user.24hr_incomplete_application" => "Incomplete application",
  "bus_list.new_captain_confirmation" => "You're a bus captain!",
  "bus_list.update_notes" => "Bus Update"
}

name_mapping = {
  "questionnaire.pending" => "Application Received",
  "questionnaire.accepted" => "Accepted email",
  "questionnaire.denied" => "Denied email",
  "questionnaire.rsvp_confirmed" => "RSVP confirmed email",
  "questionnaire.rsvp_reminder" => "RSVP Reminder",
  "user.24hr_incomplete_application" => "Incomplete application (24-hour reminder)",
  "bus_list.new_captain_confirmation" => "New bus captain confirmation",
  "bus_list.update_notes" => "Bus list update"
}

path = File.join(File.dirname(__FILE__), 'seed_messages/*.md')
files = FileList.glob(path)
files.each do |filepath|
  filename = File.basename(filepath)
  trigger = filename.sub('.md', '').sub('--', '.')

  if Message.automated.where(trigger: trigger).count >= 1
    puts "Skipping seed for automated message #{trigger}: existing automated email found"
    next
  end

  body = File.read(filepath)
  Message.create(
    type: 'automated',
    name: name_mapping[trigger],
    subject: subject_mapping[trigger],
    trigger: trigger,
    body: body
  )

  puts "Seeded automated message for #{trigger}"
end

puts "Seeding school list..."

csv_file = File.join(File.dirname(__FILE__), 'schools.csv')
csv_text = File.read(csv_file)
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  School.create(row.to_hash)
end

puts "Done"
