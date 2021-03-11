class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name , :ticker,  presence: true
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: 'Tpk_05f55bbde6be43f0919978b6c4724c7d',
      secret_token: 'Tsk_6f5c0bc24cfd461fac4057b36c2b7c21',
      endpoint: 'https://sandbox.iexapis.com/v1'
    )   
    # client.price(ticker_symbol)
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
   
  end
  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
end
