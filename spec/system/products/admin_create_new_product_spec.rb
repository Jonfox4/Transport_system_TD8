require 'rails_helper'

describe 'Admin entra na tela inicial' do
  it 'e cadastra novo produto com sucesso' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    admin = User.create!(email: 'admin@one.com', password: '123456', role: 'admin')
    # Act
    login_as admin
    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar novo produto'
    fill_in 'Código do Produto', with: 'SKU-PROD'
    fill_in 'Nome do Cliente', with: 'João'
    fill_in 'Endereço de Entrega', with: 'Rua do João'
    fill_in 'Distância', with: '500'
    fill_in 'Peso', with: '50'
    fill_in 'Altura', with: '5'
    fill_in 'Largura', with: '5'
    fill_in 'Profundidade', with: '5'
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'SKU-PROD'
    expect(page).to have_content 'João'
    expect(page).to have_content 'Rua do João'
    expect(page).to have_content 'Produto cadastrado com sucesso'
  end

  it 'e preeche form com campos vazios' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    admin = User.create!(email: 'admin@one.com', password: '123456', role: 'admin')
    # Act
    login_as admin
    visit root_path
    click_on 'Produtos'
    click_on 'Cadastrar novo produto'
    fill_in 'Código do Produto', with: ''
    fill_in 'Nome do Cliente', with: ''
    fill_in 'Endereço de Entrega', with: ''
    fill_in 'Distância', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Profundidade', with: ''
    click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Não foi possível cadastrar o produto'
    expect(page).to have_content 'Nome do Cliente não pode ficar em branco'
    expect(page).to have_content 'Endereço de Entrega não pode ficar em branco'
    expect(page).to have_content 'Distância não pode ficar em branco'
    expect(page).to have_content 'Altura não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
    expect(page).to have_content 'Profundidade não pode ficar em branco'
    expect(page).to have_content 'Peso não pode ficar em branco'
  end

  it 'e tem o login travado caso não seja admin' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    admin = User.create!(email: 'admin@one.com', password: '123456', role: 'company')
    # Act
    login_as admin
    visit products_path
    # Assert
    expect(page).to have_content 'Apenas Administradores tem acesso a essa página.'
  end
end
