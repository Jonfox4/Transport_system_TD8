require 'rails_helper'

describe 'Admin entra na tela inicial' do
  it 'e vê link para produtos' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    admin = User.create!(email: 'admin@one.com', password: '123456', role: 'admin')

    # Act
    login_as admin
    visit root_path
    # Assert
    expect(page).to have_content 'Produtos'
  end

  it 'e vê lista de produtos ao entrar na página de produtos' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    admin = User.create!(email: 'admin@one.com', password: '123456', role: 'admin')
    product = Product.create(weight: 10, height: 10, width: 5, depth: 5, customer_name: 'João',
                             customer_address: 'Rua do João 10', sku: 'CAN-0125_123', distance: 500)
    # Act
    login_as admin
    visit root_path
    click_on 'Produtos'
    # Assert
    expect(page).to have_link 'Cadastrar novo produto'
    expect(page).to have_content 'Produtos'
    expect(page).to have_content 'Código do Produto'
    expect(page).to have_content 'Nome do Cliente'
    expect(page).to have_content 'Endereço de entrega'
  end

  it 'e consegue clicar em cadastrar novo produto' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    admin = User.create!(email: 'admin@one.com', password: '123456', role: 'admin')
    # Act
    login_as admin
    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar novo produto'
    # Assert
    expect(page).to have_content 'Código do Produto'
    expect(page).to have_content 'Nome do Cliente'
    expect(page).to have_content 'Endereço de Entrega'
    expect(page).to have_content 'Distância'
    expect(page).to have_content 'Peso'
    expect(page).to have_content 'Altura'
    expect(page).to have_content 'Largura'
    expect(page).to have_content 'Profundidade'
  end
end
