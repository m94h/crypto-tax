# frozen_string_literal: true

ActiveAdmin.register CryptoOperation do
  permit_params :timestamp, :operation_type, :shares, :capital_cents, :capital_currency, :crypto_currency_id

  index do
    selectable_column
    id_column
    column :timestamp
    column :currency
    column :operation_type
    column :shares
    column :capital
    actions
  end

  filter :symbol

  form do |f|
    f.inputs do
      f.input :timestamp
      f.input :crypto_currency
      f.input :operation_type
      f.input :shares
      f.input :capital
    end
    f.actions
  end
end
