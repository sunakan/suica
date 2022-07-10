# frozen_string_literal: true

#
# 改札
#
class Gate
  #
  # 梅田駅,十三駅,三国駅
  #
  STATIONS = %i[umeda juso mikuni]

  #
  # 区間料金
  #
  FARES = [160, 190]

  #
  # @param [String] name 自駅の名前('umeda', 'juso', 'mikuni')
  #
  def initialize(name)
    @name = name
  end

  #
  # 例: 梅田駅 -> 十三駅: 160円
  # 例: 十三駅 -> 三国駅: 160円
  # 例: 梅田駅 -> 三国駅: 190円
  #
  # @param [Symbol] entered_at 乗車駅
  # @return [Integer] 乗車した駅から自駅までかかる運賃
  def calc_fare(entered_at)
    from = STATIONS.index(entered_at)
    to = STATIONS.index(@name)
    distance = to - from
    FARES[distance - 1]
  end

  #
  # 自駅で乗車
  #
  # @param [Suica] suica
  #
  def enter_by_suica(suica)
    suica.enter(@name)
  end

  #
  # 自駅で降車
  #
  # @param [Suica] suica
  # @return [False|Integer] balance Suicaの残高
  def exit_by_suica(suica)
    fare = calc_fare(suica.entered_at)
    suica.discharge(fare, @name)
  end
end
