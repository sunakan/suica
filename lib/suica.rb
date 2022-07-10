# frozen_string_literal: true

class Suica
  attr_reader :balance
  attr_reader :entered_at

  #
  # @param [Integer] balance 残高
  #
  def initialize(balance)
    @balance = balance
  end

  #
  # @param [Symbol] name 乗車駅名
  # @return [Symbol] entered_at 乗車駅名
  def enter(name)
    @entered_at = name
  end

  #
  # 支払い/控除/差し引き
  #
  # @param [Integer] 金額
  # @param [Symbol] 降車駅名
  # @return [False|Integer] 残高不足の場合: false、足りている場合、差し引いた後の残高
  def discharge(fare, name)
    if fare <= @balance
      @balance -= fare
    else
      false
    end
  end
end
