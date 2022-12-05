require 'rails_helper'

describe 'Usuário cria conta' do 
  it 'com sucesso' do
    #act
    visit root_path
    click_on 'Entrar'
    click_on 'Registrar'
    fill_in 'E-mail', with:'maria@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Registrar'

    #assert
    expect(page).to have_content 'Você realizou seu registro com sucesso.'
    expect(page).to have_button 'Sair'
    user = User.last
    expect(user.email).to eq 'maria@sistemadefrete.com.br'
  end
end