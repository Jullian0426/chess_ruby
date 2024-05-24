module Serialization
  def self.save_game(game, filename)
    File.open(filename, 'wb') do |file|
      file.write(Marshal.dump(game))
    end
  end

  def self.load_game(filename)
    File.open(filename, 'rb') do |file|
      Marshal.load(file.read)
    end
  end
end