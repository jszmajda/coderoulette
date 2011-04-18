# requirements for all!
require File.join(File.dirname(__FILE__), 'coderoulette', 'roulette_wheel')
require File.join(File.dirname(__FILE__), 'coderoulette', 'croupier')


#And a shoes app:
Shoes.app :width => 800, :height => 300 do
  croupier = Croupier.new(self)
  # heeeeeeyyyyy-yaaaa
  background "#CCC".."#88A"

  flow do
    stack :width => 100 do
      stroke "#333"
      fill "#333"
      caption "Project:"
      caption "File:"
      caption "Line:"
      caption "Committer:"

      button "Pick project folder" do
        croupier.set_project_path ask_open_folder
      end

      button "Spin Wheel!" do
        croupier.spin_wheel
      end

      button "Open Editor" do
        croupier.open_editor ENV['EDITOR']
      end
    end
    stack :width => 700 do
      croupier.project_target   = caption "", :width => 700, :height => 30
      croupier.file_target      = caption "", :width => 700, :height => 30
      croupier.line_target      = caption "", :width => 700, :height => 30
      croupier.committer_target = caption "", :width => 700, :height => 30
    end
  end
end

