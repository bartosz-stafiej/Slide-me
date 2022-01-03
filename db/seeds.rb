# frozen_string_literal: true

10.times do |i|
  User.create(email: "example#{i}@email.com", password: 'password')
end

5.times do |i|
  Address.create(addressable: User.find(i + 1), post_code: '31-213', country: 'Poland', city: 'Poznan',
                 address_line: 'Polaniecka 34')
end

Admin.create(email: 'admin@email.com', password: 'Password1!')
