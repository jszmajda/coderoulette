class Croupier
  attr_accessor :file_target, :line_target, :committer_target, :project_target

  def initialize(shoes)
    @app = shoes
  end

  def set_project_path(path)
    @wheel = RouletteWheel.new(path)
    project_target.text = @wheel.path
  end

  def spin_wheel
    file_target.text = strip_path @wheel.pick_file
    line_target.text = @wheel.pick_line
    committer_target.text = @wheel.committer
  end

  def strip_path(file)
    p = @wheel.path.gsub(/\//, "\\/")
    file.sub(/^#{p}\//, '')
  end

  def open_editor(editor_cmd)
    `#{editor_cmd} #{@wheel.file} &`
  end
end
