# requirements for all!
require File.join(File.dirname(__FILE__), 'coderoulette', 'roulette_wheel')
require File.join(File.dirname(__FILE__), 'coderoulette', 'croupier')


#And a shoes app:
Shoes.app :width => 600, :height => 400 do
  croupier = Croupier.new(self)
  # heeeeeeyyyyy-yaaaa
  background "#CCC".."#88A"

  stack :margin => 10 do
    stack :margin => 5 do
      background "#EEE"
      border "#DDD", :strokewidth => 2
      flow do
        caption "Chosen Path:"
        croupier.active_path_target = para ""
      end
      flow do
        caption "File:"
        croupier.file_target = para ""
      end
      flow do
        caption "Line:"
        croupier.line_target = para ""
      end
      flow do
        caption "Committer:"
        croupier.committer_target = para ""
      end
    end

    flow do
      button "Spin Wheel!" do
        croupier.spin_wheel
      end

      button "Open Editor", :margin_left => 5 do
        croupier.open_editor ENV['EDITOR']
      end
    end

    flow do
      caption "Projects:"

      croupier.project_target = stack :width => '100%'
      button "Add Project Path" do
        croupier.add_project_path ask_open_folder
      end
    end
  end
end

