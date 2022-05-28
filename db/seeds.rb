  s = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                              address: 'Avenida numero one', city: 'Cidade 1', state: '1')
  s2 = ShippingCompany.create!(brand_name: 'Two Transportes', corporate_name: 'Empresa Two', email_domain: 'two.com', registration_number: 22_222_222_222_222,
                               address: 'Avenida numero Two', city: 'Cidade 2', state: '2')

  u1 = User.create!(email: 'admin@one.com', password: '123456', role: 'company',shipping_company: s)
  u2 = User.create!(email: 'admin@two.com', password: '123456', role: 'company', shipping_company: s2)

  admin1 = User.create!(email: 'admin1@admin.com', password: '123456', role: 'admin')
  admin2 = User.create!(email: 'admin2@admin.com', password: '123456', role: 'admin')

  Vehicle.create!(plate: 'ONE0001', brand: 'Ford', vehicle_model: 'Ka', fabrication_year: 2012,
                  shipping_company: s)
  Vehicle.create!(plate: 'ONE0002', brand: 'Wolks', vehicle_model: 'Fox', fabrication_year: 2016,
                  shipping_company: s2)

puts 'Banco de dados criado com sucesso.'