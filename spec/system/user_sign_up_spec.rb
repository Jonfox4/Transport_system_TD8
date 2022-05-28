require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange
    s = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11111111111111,
                               address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'email2@one.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Criar conta'
    # Assert
    expect(User.last.shipping_company).to eq s
    expect(page).to have_content 'email2@one.com'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Parabéns! Sua conta foi criada com sucesso, fique à vontade para ultilizar nossos serviços.'
  end

  it 'caso usuário não esteja atrelado a uma empresa ativa' do
    # Arrange
    s = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11111111111111,
                               address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    # Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'email2@two.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Criar conta'
    # Assert
    expect(page).to have_content 'não atrelado a empresas cadastradas no sistema, favor entrar em contato com a Administração.'
  end

end
