# frozen_string_literal: true

10.times do |i|
  User.create(email: "example#{i}@email.com", password: 'password')
end

Admin.create(email: 'admin@email.com', password: 'Password1!')
