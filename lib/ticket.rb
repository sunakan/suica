# frozen_string_literal: true

class Ticket
  attr_reader :fare
  attr_reader :entered_at

  #
  # @param [Integer] fare 運賃
  #
  def initialize(fare)
    @fare = fare
  end

  #
  # @param [Symbol] name 乗車駅名
  # @return [Symbol] entered_at 乗車駅名
  def enter(name)
    @entered_at = name
  end
end
