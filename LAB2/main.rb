require './database/students_db.rb'

db = StudentsDB.new()

client = Mysql2::Client.new(:host => "localhost", :username => "root")
results = client.query("USE my_db")
results = client.query("SELECT * FROM student")
results = client.query("SELECT * FROM student WHERE id = 3")
puts results.map { |x| x.to_s }