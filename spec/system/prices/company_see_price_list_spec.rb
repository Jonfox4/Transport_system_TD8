require 'rails_helper'


describe 'Usuário entra na Index' do
  it 'e vê a lista de preços cadastrada' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    company2 = ShippingCompany.create!(brand_name: 'Rapi10', corporate_name: 'Rapi10 Transportes', email_domain: 'rapi10.com', registration_number: 22222222222222,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company)
    Price.create!(minimum_weight: '1', maximum_weight: '10', maximum_cubic_meter: '5', minimum_cubic_meter: '1',
                  price_km: '0.80', shipping_company: company)
    Price.create!(minimum_weight: '11', maximum_weight: '20', maximum_cubic_meter: '10', minimum_cubic_meter: '6',
                  price_km: '1', shipping_company: company)
    Price.create!(minimum_weight: '21', maximum_weight: '30', maximum_cubic_meter: '20', minimum_cubic_meter: '11',
                  price_km: '1.2', shipping_company: company2)
    # Act
    login_as user
    visit shipping_companies_path
    click_on 'One Transportes'
    click_on 'Configurar Preços'

    # Assert
    expect(page).to have_link 'Cadastrar novo preço'
    expect(page).to have_content 'Entre 1.0 e 10.0 Kg e 1.0 a 5.0 m³ o preço por KM é R$ 0.8'
    expect(page).to have_content 'Entre 11.0 e 20.0 Kg e 6.0 a 10.0 m³ o preço por KM é R$ 1'
    expect(page).to_not have_content 'Entre 21.0 e 30.0 Kg e 11.0 a 20.0 m³ o preço por KM é R$ 1.2'
  end
end
