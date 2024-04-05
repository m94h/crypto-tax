# frozen_string_literal: true

ActiveAdmin.register_page "Tax Operations" do
  content do
    CryptoCurrency.all.map do |crypto_currency|
      h2 crypto_currency.symbol

      tax_operations = BuildTaxOperationsForCurrency.new(crypto_currency:).call

      table_for(tax_operations, class: 'index_table') do
        column :tax_year
        column :crypto_currency
        column :shares
        column :sell_date
        column :sell_price
        column :buy_date
        column :buy_price
        column :buy_capital
        column :ipc_between_buy_and_sell_date
        column :adjusted_buy_capital
        column :profit_or_loss
        column :ipc_between_sell_date_and_end_of_year
        column :adjusted_profit_or_loss
      end

      tax_operations.group_by(&:tax_year).map do |tax_year, year_operations|
        total_adjusted_profit_or_loss = year_operations.sum(&:adjusted_profit_or_loss)

        h5 "Total profit or loss for year #{tax_year}: #{total_adjusted_profit_or_loss}"
      end

      hr
    end
  end
end
