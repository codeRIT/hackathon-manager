# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

puts "Seeding messages..."

subject_mapping = {
  "questionnaire.pending" => "Application Received",
  "questionnaire.accepted" => "You've been accepted!",
  "questionnaire.denied" => "Your application status",
  "questionnaire.rsvp_confirmed" => "RSVP Confirmation"
}

name_mapping = {
  "questionnaire.pending" => "Application Received",
  "questionnaire.accepted" => "Accepted email",
  "questionnaire.denied" => "Denied email",
  "questionnaire.rsvp_confirmed" => "RSVP confirmed email"
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
