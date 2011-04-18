class RouletteWheel
  attr_reader :path, :file, :line_number

  def initialize(path, glob_pattern="*.{rb,erb,haml,js}")
    @path = path
    @fileset = Dir["#{path}/**/#{glob_pattern}"]
    true
  end

  def pick_file
    @file = @fileset[rand(@fileset.size)]
  end

  def pick_line
    raise "Pick a file first" unless @file

    lines = File.readlines(@file)
    @line_number = (rand(lines.size) + 1).to_i
  end

  def committer
    raise "Pick a line first" unless @line_number
    @committer = `(cd #{@path}; git blame #{@file} -L #{@line_number},#{@line_number}|awk '{print $2, $3}'|sed -e's/(//')`.split(/\n/)[0]
  end
end
