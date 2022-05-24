require 'rails_helper'

describe 'Transportadora cadastra um veiculo' do
  it 'a partir da tela de detalhes de transportadora' do
    #Arrange
    u = User.create!(email:'company@company.com', password: '123456', role:'company')
    ShippingCompany.create!(brand_name:'One',corporate_name: 'Empresa One', email_domain: 'One@email.com', registration_number: 11111111111111,
                            address: 'Avenida numero one', city: 'Cidade 1', state:'1')
    #Act
    login_as u
    visit shipping_companies_path
    click_on 'Nova Transportadora'
    #Assert
  end
end
