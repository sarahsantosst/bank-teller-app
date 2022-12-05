class AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def deposit
    account = Account.find(params[:id])
    amount = params[:amount].to_f

    account.balance = account.balance + amount
    if account.save
      return redirect_to root_path, notice: "Depósito de R$ #{amount} realizado com sucesso."
    else
      return redirect_to root_path, alert: "Depósito não realizado."
    end
  end

  def withdraw
    account = Account.find(params[:id])
    amount = params[:amount].to_f

    if amount > account.balance
      return redirect_to root_path, alert: 'Você não possui saldo disponível.'
    end
    
    account.balance = account.balance - amount
    if account.save
      return redirect_to root_path, notice: "Saque de R$ #{amount} realizado com sucesso."
    else
      return redirect_to root_path, alert: 'Saque não realizado.'
    end
  end

  def transfer
    account = Account.find(params[:id])
    amount = params[:amount].to_f

    transfer_account_code = params[:transfer_account_code]
    transfer_account = Account.where(code: transfer_account_code).first

    if !defined?(transfer_account) || !transfer_account.present?
      return redirect_to root_path, alert: "Conta com código #{transfer_account_code} não encontrada."
    end

    if amount > account.balance
      return redirect_to root_path, alert: 'Você não possui saldo disponível.'
    end
    
    account.balance = account.balance - amount
    transfer_account.balance = account.balance + amount

    if account.save && transfer_account.save
      return redirect_to root_path, notice: "Transferência de R$ #{amount} realizada com sucesso."
    else
      return redirect_to root_path, alert: 'Transferência não realizada.'
    end
  end
end