require 'commander'

RSpec.describe Commander do

  it 'creates command instructions' do
    commands = 'RMLM'
    cmd = Commander.new(commands)
    expect(cmd.commands).to eq(commands.split(''))
  end

  it 'gets first command' do
    commands = 'MMM'
    cmd = Commander.new(commands)
    expect(cmd.commands).to eq(commands[0])
  end

  it 'has completed all commands' do
    commands = 'M'
    cmd = Commander.new(commands)
    cmd.run
    expect(cmd.commands).to eq(nil)
  end

  it 'fails due to illegal command' do
    commands = 'OMG'
    expect { Commander.new(commands) }.to raise_error(StandardError)
  end

end