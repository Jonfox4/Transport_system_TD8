require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    # Arrange
    s = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    User.create!(email: 'email1@one.com', password: 'password', shipping_company: s)

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'email1@one.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    # Assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    within('nav') do
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'email1@one.com'
    end
  end

  it 'e faz logout' do
    # Arrange
    s = ShippingCompany.create!(brand_name: 'One Transportes', corporate_name: 'Empresa One', email_domain: 'one.com', registration_number: 11_111_111_111_111,
                                address: 'Avenida numero one', city: 'Cidade 1', state: '1')
    User.create!(email: 'email1@one.com', password: 'password', role: 'company', shipping_company: s)

    # Act
    visit root_path
    click_on 'Entrar'
    within('form') do
      fill_in 'E-mail', with: 'email1@one.com'
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    click_on 'Sair'

    # Assert
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_link 'Sair'
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_content 'email1@one.com'
  end
end
