require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    #Arrange

    #Act
    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma conta'
    fill_in 'E-mail', with: 'email2@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Criar conta'
    #Assert
    expect(page).to have_content 'email2@email.com'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Parabéns! Sua conta foi criada com sucesso, fique à vontade para ultilizar nossos serviços.'
  end
end
