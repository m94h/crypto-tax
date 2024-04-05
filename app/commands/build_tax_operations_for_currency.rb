# frozen_string_literal: true

class BuildTaxOperationsForCurrency
  def initialize(crypto_currency:)
    @crypto_currency = crypto_currency
  end

  def call
    @buy_operation_cursor = nil
    @sell_operation_cursor = nil

    @completed_sell_shares = 0
    @completed_buy_shares = 0

    @tax_operations = []

    loop do
      begin
        @sell_operation_cursor = sell_operations.next
        @completed_sell_shares = 0
      rescue StopIteration
        break
      end

      loop do
        if @buy_operation_cursor.blank? || @completed_buy_shares == @buy_operation_cursor.shares
          @buy_operation_cursor = buy_operations.next
          @completed_buy_shares = 0
        end

        sell_shares_to_complete = @sell_operation_cursor.shares - @completed_sell_shares
        available_buy_shares_to_complete = @buy_operation_cursor.shares - @completed_buy_shares

        shares_to_complete = [sell_shares_to_complete, available_buy_shares_to_complete].min

        @tax_operations << TaxOperation.new(
          crypto_currency: @crypto_currency,
          sell_date: @sell_operation_cursor.timestamp.to_date,
          buy_date: @buy_operation_cursor.timestamp.to_date,
          shares: shares_to_complete,
          buy_price: @buy_operation_cursor.price,
          sell_price: @sell_operation_cursor.price
        )

        @completed_sell_shares += shares_to_complete
        @completed_buy_shares += shares_to_complete

        break if @completed_sell_shares == @sell_operation_cursor.shares
      end
    end

    @tax_operations
  end

  private

  def sell_operations
    @sell_operations ||= CryptoOperation.where(
      operation_type: 'sell',
      crypto_currency: @crypto_currency
    ).order(timestamp: :asc).to_enum
  end

  def buy_operations
    @buy_operations ||= CryptoOperation.where(
      operation_type: 'buy',
      crypto_currency: @crypto_currency
    ).order(timestamp: :asc).to_enum
  end
end
