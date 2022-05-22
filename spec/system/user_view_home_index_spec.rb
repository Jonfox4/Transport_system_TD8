require 'rails_helper'

describe 'Usuário visita a home do aplicativo' do
  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path

    # Assert
    expect(page).to have_content 'Sistema de Transporte'
    expect(page).to have_content 'Boas Vindas'
    expect(page).to have_content I18n.localize(Date.today)
    within('nav') do
      expect(page).to have_link 'Entrar'
    end
  end
end
