require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'com sucesso' do 
    #arrange
    User.create!(name: 'Sarah Santos', email: 'sarah@sistemadefrete.com.br', password: 'password')

    #act
    visit root_path
    within('form') do 
      fill_in 'E-mail', with: 'sarah@sistemadefrete.com.br'
      fill_in  'Senha', with: 'password'
      click_on 'Entrar'
    end

    #assert
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(page).not_to have_link 'Entrar'
    expect(page).to have_button 'Sair'
  end

  it 'e faz logout' do 
    #arrange
    User.create!(name: 'John Doe', email:'johndoe@sistemadefrete.com.br', password:'password')
    
    #act
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'johndoe@sistemadefrete.com.br'
    fill_in 'Senha', with: 'password'
    within('form') do
      click_on 'Entrar'
    end
    click_on 'Sair'

    #assert
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end
end
