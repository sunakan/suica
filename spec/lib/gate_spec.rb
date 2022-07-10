require_relative '../spec_helper.rb'
require_relative '../../lib/gate.rb'

RSpec.describe 'Gate' do
  # 説明
  describe '#calc_fare' do
    # コンテキスト: 〇〇の場合
    context '梅田駅 -> 十三駅の場合' do
      # テスト内容
      it '運賃は160円' do
        juso = Gate.new(:juso)
        actual = juso.calc_fare(:umeda)
        expected = 160
        expect(actual).to eq expected
      end
    end

    context '梅田駅 -> 三国駅の場合' do
      it '運賃は190円' do
        mikuni = Gate.new(:mikuni)
        actual = mikuni.calc_fare(:umeda)
        expected = 190
        expect(actual).to eq expected
      end
    end
  end

  #
  # 責務
  #   引数のenterメソッドをcallすること
  #
  describe '#enter_by_suica(suica)' do
    it 'Suica#enterが1度だけcallされること' do
      from_gate = Gate.new(:umeda)
      suica_double = Suica.new(0)

      expect(suica_double).to receive(:enter).with(:umeda).once
      from_gate.enter_by_suica(suica_double)
    end
  end

  #
  # 責務
  #  call Suica#entered_at
  #  call Self#calc_fare
  #  call Suica#discharge
  describe '#exit_by_suica(suica)' do
    # 降車駅: 十三駅
    let!(:exit_gate) { Gate.new(:juso) }
    let!(:suica) { Suica.new(nil) }

    context '乗車駅が梅田駅の場合' do
      before do
        expect(suica).to receive(:entered_at).once.and_return(:umeda)
      end
      it 'Suica#dischargeが1度callされ、その戻り値がそのまま戻り値となる' do
        expect(suica).to receive(:discharge).once.and_return(100) # Suica#dischargeが100を返した場合
        actual = exit_gate.exit_by_suica(suica)
        expected = 100
        expect(actual).to eq expected
      end
      it 'Suica#dischargeが1度callされ、その戻り値がそのまま戻り値となる2' do
        expect(suica).to receive(:discharge).once.and_return(false) # Suica#dischargeがfalseを返した場合
        actual = exit_gate.exit_by_suica(suica)
        expected = false
        expect(actual).to eq expected
      end
    end
  end
end
