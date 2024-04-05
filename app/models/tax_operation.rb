# frozen_string_literal: true

class TaxOperation
  attr_reader :crypto_currency, :shares, :buy_price, :sell_price, :buy_date, :sell_date

  def initialize(crypto_currency:, shares:, buy_price:, sell_price:, buy_date:, sell_date:)
    @crypto_currency = crypto_currency
    @shares = shares
    @buy_price = buy_price
    @sell_price = sell_price
    @buy_date = buy_date
    @sell_date = sell_date
  end

  def tax_year
    sell_date.year
  end

  def buy_capital
    buy_price * shares
  end

  def adjusted_buy_capital
    buy_capital * (1 + ipc_between_buy_and_sell_date)
  end

  def profit_or_loss
    sell_price * shares - adjusted_buy_capital
  end

  def adjusted_profit_or_loss
    profit_or_loss * (1 + ipc_between_sell_date_and_end_of_year)
  end

  def ipc_between_buy_and_sell_date
    Ipc.value_between_dates(buy_date, sell_date)
  end

  def ipc_between_sell_date_and_end_of_year
    Ipc.value_between_dates(sell_date + 1.month, sell_date.end_of_year)
  end
end
