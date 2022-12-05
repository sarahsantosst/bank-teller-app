require 'rails_helper'

describe 'Usuario abre uma conta' do 
  it 'e vê informações sobre sua conta' do
    user = User.create!(name: 'John Doe', email:'johndoe@sistemadefrete.com.br', password:'password')

    #act
    login_as(user)
    visit root_path
    click_on 'Abra sua conta'
    
    #assert 
    account = Account.where(user: user).first
    expect(page).to have_content("Conta:\n#{account.code}")
    expect(page).to have_content("Saldo:\n0.0")
    expect(page).to have_content('Depósito')
    expect(page).to have_content('Saque')
    expect(page).to have_content('Transferência')
  end
end
