class CryptoCurrency < ApplicationRecord
  validates :name, :symbol, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["symbol"]
  end
end

# == Schema Information
#
# Table name: crypto_currencies
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  symbol     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
