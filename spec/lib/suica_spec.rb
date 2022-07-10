require_relative '../spec_helper.rb'
require_relative '../../lib/suica.rb'

RSpec.describe 'Suica' do
  describe 'initialize' do
    it '残高1000円でインスタンス化できる' do
      actual = Suica.new(1000) # 実際
      expected = 1000          # 期待値
      expect(actual.balance).to eq expected
    end
    it '残高800円でインスタンス化できる' do
      actual = Suica.new(800)
      expected = 800
      expect(actual.balance).to eq expected
    end
  end

  describe '#enter' do
    context '梅田駅で乗車した場合' do
      it '乗車駅は梅田駅になる' do
        suica = Suica.new(1000)
        suica.enter(:umeda)
        actual = suica.entered_at
        expected = :umeda
        expect(actual).to eq expected
      end
    end
  end

  describe '#discharge(fare, name)' do
    let!(:suica) { Suica.new(160) }
    context '運賃より残高が高い場合' do
      let!(:fare) { 100 }
      it '差し引かれた後の残高が戻り値となる' do
        actual = suica.discharge(fare, 'ignore')
        expected = 60
        expect(actual).to eq expected
        expect(suica.balance).to eq expected
      end
    end

    context '運賃と残高が同じ場合' do
      let!(:fare) { suica.balance }
      it '差し引かれた後の残高が戻り値(0円)となる' do
        actual = suica.discharge(fare, 'ignore')
        expected = 0
        expect(actual).to eq expected
        expect(suica.balance).to eq expected
      end
    end

    context '運賃より残高が低い場合' do
      let!(:fare) { 200 }
      it '残高はそのままで、falseが戻り値となる' do
        actual = suica.discharge(fare, 'ignore')
        expect(actual).to eq false
        expect(suica.balance).to eq 160
      end
    end
  end
end
