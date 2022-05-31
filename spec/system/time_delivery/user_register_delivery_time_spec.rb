require "rails_helper"

describe "User registra tempo de entrega" do
  it "com sucesso" do
    #Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company)

    #Act
    login_as user
    visit root_path
    click_on "Transportadora"
    click_on 'One Transportes'
    click_on "Cadastrar prazo de entrega"
    click_on "Adicionar Prazo"
    fill_in "Distancia mínima:", with: "20"
    fill_in "Distancia maxíma", with: "70"
    fill_in "Prazo de entrega", with: "5"
    click_on "Enviar"
    #Assert
    expect(current_path).to eq new_shipping_company_time_delivery_path(company)
    expect(page).to have_content "Prazo cadastrado com sucesso."
  end

  it "com data incompleta" do
    #Arrange
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                     address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company)
    #Act
    login_as user
    visit new_shipping_company_time_delivery_path(company)
    fill_in "Distancia mínima:", with: " "
    fill_in "Distancia maxíma", with: " "
    fill_in "Prazo de entrega", with: " "
    click_on "Enviar"
    #Assert
    expect(page).to have_content "não pode ficar em branco"
    expect(page).to have_content "Prazo não cadastrado."
    expect(page).to have_link "Voltar"
  end

  it "e precisa estar logado" do
    #Assert
    company = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                      address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    user = user = User.create!(email: 'admin@one.com', password: '123456', role: 'company', shipping_company: company) 
    #Act
    visit new_shipping_company_time_delivery_path(company)
    #Assert
    expect(page).to have_content "Para continuar, faça login ou registre-se."
  end
end
