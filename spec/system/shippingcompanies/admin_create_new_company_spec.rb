require 'rails_helper'

require 'rails_helper'

describe 'Admin cadastra uma transportadora' do
  it 'a partir da tela de transportadoras' do
    #Arrange
    u = User.create!(email:'admin@admin.com',password: '123456', role:'admin' )
    #Act
    login_as u
    visit shipping_companies_path
    click_on 'Nova Transportadora'
    #Assert
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('Domínio de E-mail')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
  end

  it 'com sucesso' do
    #Arrange
    u = User.create!(email:'admin@admin.com',password: '123456', role:'admin' )
    #Act
    login_as u
    visit shipping_companies_path
    click_on 'Nova Transportadora'
    fill_in 'Nome Fantasia', with: 'Transportadora Rapi10'
    fill_in 'Razão Social', with: 'Rapi10 Transportes'
    fill_in 'Domínio de E-mail', with: 'email@rapi10.com.br'
    fill_in 'CNPJ', with: '12345678910111'
    fill_in 'Endereço', with: 'Rua das transportadoras, 100'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    click_on 'Enviar'
    #Assert
    # expect(current_path).to eq shipping_companies_path(ShippingCompany.last)
    expect(page).to have_content 'Transportadora Rapi10'
  end

  it 'com dados incompletos' do
    #Arrange
    u = User.create!(email:'admin@admin.com',password: '123456', role:'admin' )
    #Act
    login_as u
    visit shipping_companies_path
    click_on 'Nova Transportadora'
    fill_in 'Nome Fantasia', with: ''
    click_on "Enviar"
    #Assert
    expect(page).to have_content 'Transportadora não cadastrada'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Domínio do E-mail não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
   end

   it 'com CNPJ de 10 digitos' do
     #Arrange
     u = User.create!(email:'admin@admin.com',password: '123456', role:'admin' )  
     #Act
     login_as u
     visit shipping_companies_path
     click_on 'Nova Transportadora'
     fill_in 'Nome Fantasia', with: 'Transportadora Rapi10'
     fill_in 'Razão Social', with: 'Rapi10 Transportes'
     fill_in 'Domínio de E-mail', with: 'email@rapi10.com.br'
     fill_in 'CNPJ', with: '123456789101'
     fill_in 'Endereço', with: 'Rua das transportadoras, 100'
     fill_in 'Cidade', with: 'São Paulo'
     fill_in 'Estado', with: 'SP'
     click_on "Enviar"
     #Assert
     expect(page).to have_content 'CNPJ não possui o tamanho esperado (14 caracteres)'
     end

   it 'com alguns dados já existentes' do
      #Arrange
      u = User.create!(email:'admin@admin.com',password: '123456', role:'admin' )
      s2 = ShippingCompany.create!(brand_name:'Two',corporate_name: 'Empresa Two', email_domain: 'Two@email.com', registration_number: 22222222222222,
                                   address: 'Avenida numero Two', city: 'Cidade 2', state:'2')
      #Act
      login_as u
      visit shipping_companies_path
      click_on 'Nova Transportadora'
      fill_in 'Nome Fantasia', with: 'Two'
      fill_in 'Razão Social', with: 'Empresa Two'
      fill_in 'Domínio de E-mail', with: 'Two@email.com'
      fill_in 'CNPJ', with: '22222222222222'
      fill_in 'Endereço', with: 'Avenida numero Two'
      fill_in 'Cidade', with: 'Cidade 2'
      fill_in 'Estado', with: '2'
      click_on "Enviar"
      #Assert
      expect(page).to have_content 'Transportadora não cadastrada.'
      expect(page).to have_content 'Domínio do E-mail já está em uso'
      expect(page).to have_content 'CNPJ já está em uso'
      expect(page).to have_content 'Razão Social já está em uso'
      expect(page).to have_content 'Nome Fantasia já está em uso'
      end
end
