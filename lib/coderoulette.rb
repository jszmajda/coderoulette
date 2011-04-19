# requirements for all!
require File.join(File.dirname(__FILE__), 'coderoulette', 'roulette_wheel')
require File.join(File.dirname(__FILE__), 'coderoulette', 'croupier')


#And a shoes app:
Shoes.app :width => 500, :height => 300 do
  croupier = Croupier.new(self)
  # heeeeeeyyyyy-yaaaa
  background "#CCC".."#88A"

  stack  do
    stroke "#333"
    fill "#333"
    flow do
      caption "Project:"
      croupier.project_target   = caption ""
    end
    flow do
      caption "File:"
      croupier.file_target      = caption ""
    end
    flow do
      caption "Line:"
      croupier.line_target      = caption ""
    end
    flow do
      caption "Committer:"
      croupier.committer_target = caption ""
    end

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
end

