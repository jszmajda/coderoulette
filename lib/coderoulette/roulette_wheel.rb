class RouletteWheel
  attr_reader :pathset, :file, :line_number, :pathkey

  def initialize(glob_pattern="*.{rb,erb,haml,js,coffee}")
    @glob_pattern = glob_pattern
    @pathset = []
    @fileset = {}
    true
  end

  def add_path(path)
    @pathset << path
    reindex_files
  end

  def remove_path(path)
    ix = @pathset.delete(path)
    reindex_files if ix
  end

  def reindex_files
    @fileset = {}
    @pathset.each do |path|
      @fileset[path] = Dir["#{path}/**/#{@glob_pattern}"]
    end
  end

  def pick_file
    @pathkey = @fileset.keys[rand(@fileset.keys.size)]
    @file = @fileset[@pathkey][rand(@fileset[@pathkey].size)]
  end

  def pick_line
    raise "Pick a file first" unless @file

    lines = File.readlines(@file)
    @line_number = (rand(lines.size) + 1).to_i
  end

  def committer
    raise "Pick a line first" unless @line_number
    @committer = `(cd #{@pathkey}; git blame #{@file} -L #{@line_number},#{@line_number}|awk '{print $2, $3}'|sed -e's/(//')`.split(/\n/)[0]
  end
end
