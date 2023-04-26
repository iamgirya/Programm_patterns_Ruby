require 'mysql2'

client = Mysql2::Client.new(:host => "localhost", :username => "root")

client.query("DROP DATABASE test_db")
client.query("CREATE DATABASE test_db")
client.query("USE test_db")
client.query("CREATE TABLE users(username CHAR(20));")
client.query('INSERT INTO users (username) VALUES ROW("aboba")')

results = client.query("SELECT * FROM users")
puts results.map { |x| x.to_s }