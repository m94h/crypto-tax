# frozen_string_literal: true

class Ipc < ApplicationRecord
  validates :date, :value, presence: true

  def self.value_between_dates(start_date, end_date)
    adjusted_start_date = start_date.beginning_of_month
    adjusted_end_date = end_date.beginning_of_month

    result = where(date: adjusted_start_date..adjusted_end_date).pluck(:value).reduce(1.0) do |result, value|
      result * (1 + value)
    end

    (result - 1).round(4)
  end
end

# == Schema Information
#
# Table name: ipcs
#
#  id    :bigint           not null, primary key
#  date  :date             not null
#  value :decimal(, )      not null
#
