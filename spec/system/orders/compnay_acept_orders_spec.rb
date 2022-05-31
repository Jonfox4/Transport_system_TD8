require 'rails_helper'

 
describe 'Usuário aceita um produto' do
  it 'com sucesso' do
    #Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    company2 = ShippingCompany.create!(brand_name: 'Rapi10', corporate_name: 'Rapi10 Transportes', email_domain: 'rapi10.com', registration_number: 22_222_222_222_222,
                                       address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company)
    produto = Product.create!(weight: 5, height: 5, width: 5, depth: 5, customer_name: 'João', customer_address: 'Rua do João',
                              sku: 'COD-158', distance: '20' )

    #Act
    login_as user
    #Assert

  end
end
