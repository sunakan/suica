require_relative '../spec_helper.rb'
require_relative '../../lib/ticket.rb'

RSpec.describe 'Ticket' do
  describe 'initialize' do
    it '350円の運賃でインスタンス化' do
      actual = Ticket.new(350)
      expected = 350
      expect(actual.fare).to eq expected
    end
    it '500円の運賃でインスタンス化' do
      actual = Ticket.new(500)
      expected = 500
      expect(actual.fare).to eq expected
    end
  end
end
