require 'rails_helper'

describe 'usuário entra na tela de sua empresa' do
  it 'e vê a lista de veículos de sua empresa' do
    #Arrange
    u = User.create!(email:'company@company.com', password: '123456', role:'admin')
    company = ShippingCompany.create!(brand_name:'One',corporate_name: 'Empresa One', email_domain: 'One@email.com', registration_number: 11111111111111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    Vehicle.create!(plate: 'ONE0001', brand: 'Ford', vehicle_model: 'Ka', fabrication_year: 2012, shipping_company: company)
    Vehicle.create!(plate: 'ONE0002', brand: 'Wolks', vehicle_model: 'Fox', fabrication_year: 2016, shipping_company: company)
    #Act
    login_as u
    visit shipping_companies_path
    click_on company.brand_name
    expect(page).to have_content 'Veículos da Empresa'

    #Assert
    expect(page).to have_content 'ONE0001'
    expect(page).to have_content 'Ford'
    expect(page).to have_content 'Ka'
    expect(page).to have_content '2012'
    expect(page).to have_content 'ONE0002'
    expect(page).to have_content 'Wolks'
    expect(page).to have_content 'Fox'
    expect(page).to have_content '2016'
  end

  it 'e cadastra um novo veículo' do
    #Arrange
    u = User.create!(email:'company@company.com', password: '123456', role: 'admin')
    company = ShippingCompany.create!(brand_name:'One',corporate_name: 'Empresa One', email_domain: 'One@email.com', registration_number: 11111111111111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    #Act
    login_as u
    visit shipping_companies_path
    click_on company.brand_name
    click_on 'Cadastrar novo veículo'
    fill_in 'Placa', with: 'ONE0001'
    fill_in 'Marca', with: 'Ford'
    fill_in 'Modelo', with: 'Ka'
    fill_in 'Ano de fabricação', with: '2012'
    click_on 'Enviar'
    #Assert
    expect(page).to have_content 'Ford'
    expect(page).to have_content 'Ka'
    expect(page).to have_content '2012'
  end
end
