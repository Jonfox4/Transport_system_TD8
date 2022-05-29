require 'rails_helper'

describe 'Usuário cadastra seus preços' do
  it 'a partir da tela de transportadoras' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company)
    # Act
    login_as user
    visit shipping_companies_path
    click_on 'One Transportes'
    # Assert
    expect(page).to have_content 'Configurar Preços'
  end

  it 'com sucesso' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company)

    # Act
    login_as user
    visit shipping_companies_path
    click_on 'One Transportes'
    click_on 'Configurar Preços'
    click_on 'Cadastrar novo preço'
    fill_in 'Peso mínimo', with: '0'
    fill_in 'Peso máximo', with: '10'
    fill_in 'Minímo m³', with: '0.0001'
    fill_in 'Máximo m³', with: '0.500'
    fill_in 'Valor por Km', with: '0.75'
    click_on 'Enviar'

    expect(page).to have_content 'Entre 0 a 0 m³ e peso entre 0.0 e 10.0 kgs o valor é de 0 reais por km.'
  end

  it 'com dados incompletos' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company)
    # Act
    login_as user
    visit shipping_companies_path
    click_on 'Configurar preços'
    click_on 'Cadastrar preço'
    fill_in 'Peso mínimo', with: ''
    fill_in 'Peso maximo', with: ''
    fill_in 'Minímo m³', with: ''
    fill_in 'Máximo m³', with: ''
    fill_in 'Valor do Km', with: ''
    click_on 'Cadastrar'
    # Assert
    expect(page).to have_content 'Peso mínimo não pode ficar em branco'
    expect(page).to have_content 'Peso máximo não pode ficar em branco'
    expect(page).to have_content 'Mínimo m³ não pode ficar em branco'
    expect(page).to have_content 'Máximo m³ não pode ficar em branco'
    expect(page).to have_content 'Valor do KM não pode ficar em branco'
  end

  it 'da erro se usuário não estiver logado' do
    # Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company)
    # Act
    visit shipping_companies_path
    login_as user
    visit shipping_companies_path
    # Assert
    expect(page).to have_content 'Você deve efetuar o login para continuar'
  end
end
