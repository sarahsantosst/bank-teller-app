class HomeController < ApplicationController
  def index
    @account = Account.where(user: current_user).first
  end

  def create_account
    @account = Account.new(user: current_user)
    if @account.save()
      flash.now[:notice] = 'Conta cadastrada com sucesso.'
    else
      flash.now[:alert] = 'Conta não cadastrada'
    end
    render 'index'
  end

  def totaly_balance
    @account = Account.find(params[:id])
    params.require(:balance).permit(:balance, :deposit)
  end
end