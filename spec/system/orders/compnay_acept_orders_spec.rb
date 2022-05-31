require 'rails_helper'

describe 'Admin cria uma nova ordem de serviço' do
  it 'a partir do menu principal' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    admin = User.create!(email: 'admin@one.com', password: '123456', role: 'admin')
    produto = Product.create!(weight: 5, height: 5, width: 5, depth: 5, customer_name: 'João', customer_address: 'Rua do João',
                              sku: 'COD-158', distance: '20')

    # Act
    login_as admin
    visit root_path
    click_on 'Produtos'
    click_on 'Gerar ordem de serviço'
    # Assert
  end

  it 'e consegue visualizar todos os preços das companias' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    admin = User.create!(email: 'admin@one.com', password: '123456', role: 'admin')
    produto = Product.create!(weight: 5, height: 5, width: 5, depth: 5, customer_name: 'João', customer_address: 'Rua do João',
                              sku: 'COD-158', distance: '20')
    # Act
    login_as admin
    visit root_path
    click_on 'Produtos'
    click_on 'Gerar ordem de serviço'
    click_on 'Criar nova ordem de serviço'
    # Assert
    expect(page).to have_content 'Transportadora'
    expect(page).to have_content 'Veículo'
    expect(page).to have_content 'Cod. Produto'
    expect(page).to have_content 'Endereço do Cliente'
    expect(page).to have_content 'Nome do Cliente'
    expect(page).to have_content 'Estimativa de entrega'
  end

  it 'e usuário consegue ver a lista de ordens de serviço' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = User.create!(email: 'admin@one.com', password: '123456', role: 'company')
    produto = Product.create!(weight: 5, height: 5, width: 5, depth: 5, customer_name: 'João', customer_address: 'Rua do João',
                              sku: 'COD-158', distance: '20')
    veiculo = Vehicle.create!(plate: 'PFV1245', brand: 'Fox', vehicle_model: 'Wolks', fabrication_year: '2017', shipping_company: company)
    Order.create!(shipping_company: company, vehicle: veiculo, product: produto, customer_address: 'Rua 1', customer_name: 'Jonathan', delivery_date: 1.day.from_now)
    # Act
    login_as user
    visit root_path
    click_on 'Produtos'
    click_on 'Ordem de serviço'
    # Assert
    expect(page).to have_content 'One Transportes'
    expect(page).to have_content 'Fox'
    expect(page).to have_content 'COD-158'
    expect(page).to have_content 'Rua 1'
    expect(page).to have_content 'Jonathan'
  end
end
