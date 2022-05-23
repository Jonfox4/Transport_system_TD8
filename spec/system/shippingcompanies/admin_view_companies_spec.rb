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
    ShippingCompany.create!(brand_name:'One',corporate_name: 'Empresa One', email_domain: 'One@email.com', registration_number: 11111111111111,
                            address: 'Avenida numero one', city: 'Cidade 1', state:'1')
    ShippingCompany.create!(brand_name:'Two',corporate_name: 'Empresa Two', email_domain: 'Two@email.com', registration_number: 22222222222222,
                            address: 'Avenida numero Two', city: 'Cidade 2', state:'2')
    #Act
    visit shipping_companies_path
    #Assert
    expect(page).to have_content 'One'
    expect(page).to have_content 'Two'
  end
 
   it 'e vê detalhes de uma transportadora' do
    #Arrange
    ShippingCompany.create!(brand_name:'One',corporate_name: 'Empresa One', email_domain: 'One@email.com', registration_number: 11111111111111,
                            address: 'Avenida numero one', city: 'Cidade 1', state:'1')
    ShippingCompany.create!(brand_name:'Two',corporate_name: 'Empresa Two', email_domain: 'Two@email.com', registration_number: 22222222222222,
                            address: 'Avenida numero Two', city: 'Cidade 2', state:'2')
    #Act
    visit shipping_companies_path
    click_on 'One'
    #Assert
    expect(page).to have_content 'Empresa One'
    expect(page).to have_content 'One'
    expect(page).to have_content 'One@email.com'
    expect(page).to have_content 'Avenida numero one'
    expect(page).to have_content 'Cidade 1'
    expect(page).to have_content '1'
    expect(page).not_to have_content 'Empresa Two'
   end

   it 'volta para tela anterior' do
    #Arrange
    s = ShippingCompany.create!(brand_name:'One',corporate_name: 'Empresa One', email_domain: 'One@email.com', registration_number: 11111111111111,
                                address: 'Avenida numero one', city: 'Cidade 1', state:'1')
    s2 = ShippingCompany.create!(brand_name:'Two',corporate_name: 'Empresa Two', email_domain: 'Two@email.com', registration_number: 22222222222222,
                                address: 'Avenida numero Two', city: 'Cidade 2', state:'2')
    #Act
    visit ("shipping_companies/#{s.id}")
    click_on 'Voltar'
    #Assert
    expect(page).to have_content 'One'
    expect(page).to have_content 'Two'
   end

   it 'e deve estar logado para ver uma lista de transportadoras' do
   end

end
