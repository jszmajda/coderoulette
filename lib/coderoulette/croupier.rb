class Croupier
  attr_accessor :file_target, :line_target, :committer_target, :project_target, :active_path_target

  def initialize(shoes)
    @app = shoes
    @wheel = RouletteWheel.new
  end

  def add_project_path(path)
    @wheel.add_path(path)

    redraw_projects
  end

  def remove_project_path(path)
    @wheel.remove_path(path)

    redraw_projects
  end

  def redraw_projects
    project_target.clear
    @wheel.pathset.each do |p|
      project_target.flow :width => '100%' do
        @app.para p
        @app.button "-", :margin_left => 5 do
          self.remove_project_path(p)
        end
      end
    end
  end

  def spin_wheel
    if @wheel.pathset.empty?
      active_path_target.text = "Pick some project paths, why don'tcha?"
    else
      file_target.text = strip_path @wheel.pick_file
      active_path_target.text = @wheel.pathkey
      line_target.text = @wheel.pick_line
      committer_target.text = @wheel.committer
    end
  end

  def strip_path(file)
    p = @wheel.pathkey.gsub(/\//, "\\/")
    file.sub(/^#{p}\//, '')
  end

  def open_editor(editor_cmd)
    `#{editor_cmd} #{@wheel.file} &`
  end
end
