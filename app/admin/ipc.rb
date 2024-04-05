# frozen_string_literal: true

ActiveAdmin.register Ipc do
  config.filters = false

  permit_params :date, :value

  index do
    selectable_column
    id_column
    column :date
    column :value
    actions
  end

  form do |f|
    f.inputs do
      f.input :date
      f.input :value
    end
    f.actions
  end
end
