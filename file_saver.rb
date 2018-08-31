require 'fileutils'
require 'yaml'

class FileSaver
  FILE_PATH = 'recipes.yml'

  def initialize(initial_hash = {})
    return save_all(initial_hash) unless File.exist?(FILE_PATH)
    FileUtils.touch FILE_PATH
  end

  def save_all(hash = {})
    File.open(FILE_PATH, "w") { |file| file.write(hash.to_yaml) }
  end

  def all
    YAML.load(File.read(FILE_PATH))
  end

  def empty?
    all.values.flatten.empty?
  end
end
