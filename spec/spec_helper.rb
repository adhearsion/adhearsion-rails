require 'ahn_rails'

Adhearsion::Logging.silence!

def stub_file_checking_methods!
  File.should_receive(:directory?).and_return true
  File.should_receive(:exists?).and_return true
end