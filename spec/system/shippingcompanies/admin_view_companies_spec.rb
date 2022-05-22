require 'rails_helper'

describe 'Usuário vê as empresas de transporte' do
  it 'após o login' do
    #Arrange

    #Act
    visit shipping_companies_path

    #Assert
    expect(page).to have_content 'Transportadoras:'
  end

  it 'vê uma lista de transportadoras' do
    #Arrange
    ShippingCompany.create!(brand_name:'One',corporate_name: 'Empresa One', email_domain: 'One@email.com', registration_number: 1234567891011,
                            address: 'Avenida numero one', city: 'Cidade 1', state:'1')
    ShippingCompany.create!(brand_name:'Two',corporate_name: 'Empresa Two', email_domain: 'Two@email.com', registration_number: 1244567891011,
                            address: 'Avenida numero Two', city: 'Cidade 2', state:'2')
    #Act
    visit shipping_companies_path
    #Assert
    expect(page).to have_content 'One'
    expect(page).to have_content 'Two'
  end

end
