require_relative '../item'

describe Item do
  describe '#choose' do
    before do
      io_obj = double
      expect(subject)
        .to receive(:gets)
        .and_return(io_obj)
        .twice
      expect(io_obj)
        .to receive(:chomp)
        .and_return("Sponge")
      expect(io_obj)
        .to receive(:chomp)
        .and_return("10")
    end

    it 'sets @type and @quantity according to user\'s input' do
      subject.choose

      expect(subject.instance_variable_get(:@type)).to eq "Sponge"
      expect(subject.instance_variable_get(:@quantity)).to eq "10"
    end
  end
end