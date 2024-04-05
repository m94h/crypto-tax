# frozen_string_literal: true

ActiveAdmin.register CryptoCurrency do
  permit_params :symbol, :name

  index do
    selectable_column
    id_column
    column :name
    column :symbol
    column :created_at
    actions
  end

  filter :symbol

  form do |f|
    f.inputs do
      f.input :name
      f.input :symbol
    end
    f.actions
  end
end
