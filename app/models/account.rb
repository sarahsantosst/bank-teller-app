class Account < ApplicationRecord
  belongs_to :user
  before_validation :init, on: :create
  
  validates :code, :balance, :user_id, presence: true

  def deposit
    @account = Account.find(params[:id])
    @account.balance = @account.balance + params[:amount].to_f
    if @account.save
      flash.now[:notice] = 'Depósito relizado com sucesso.'
    else
      flash.now[:alert] = 'Depósito não realizado'
    end
    render 'home#index'
  end

  private 
  
  def init
    self.code = SecureRandom.alphanumeric(6).upcase
    self.balance = 0
  end
end
