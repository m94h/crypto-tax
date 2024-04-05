# frozen_string_literal: true

class CryptoOperation < ApplicationRecord
  enum operation_type: [ :buy, :sell ]

  belongs_to :crypto_currency, optional: false

  validates :shares, :timestamp, :capital, :operation_type, presence: true

  monetize :capital_cents
end

# == Schema Information
#
# Table name: crypto_operations
#
#  id                 :bigint           not null, primary key
#  capital_cents      :integer          not null
#  capital_currency   :string           not null
#  operation_type     :string           not null
#  shares             :decimal(, )      not null
#  timestamp          :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  crypto_currency_id :bigint           not null
#
# Indexes
#
#  index_crypto_operations_on_crypto_currency_id  (crypto_currency_id)
#  index_crypto_operations_on_operation_type      (operation_type)
#
# Foreign Keys
#
#  fk_rails_...  (crypto_currency_id => crypto_currencies.id)
#
