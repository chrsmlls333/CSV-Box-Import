require 'sketchup.rb'
require 'csv.rb'

module CEM
  module CSVCube

    def self.create_cube
      model = Sketchup.active_model
      model.start_operation('Create Cube', true)
      group = model.active_entities.add_group
      entities = group.entities
      points = [
        Geom::Point3d.new(0,   0,   0),
        Geom::Point3d.new(1.m, 0,   0),
        Geom::Point3d.new(1.m, 1.m, 0),
        Geom::Point3d.new(0,   1.m, 0)
      ]
      face = entities.add_face(points)
      face.pushpull(-1.m)
      model.commit_operation
    end


    def self.import_cubes

      model = Sketchup.active_model
      model.start_operation('Import Cubes', true)
      importFileName = UI.openpanel("Read CSV File", Sketchup.find_support_file("Plugins"), '*.csv')

      i = 0
      CSV.foreach(importFileName) do |line|  #get file record:  account number, account name, balance

      	x = line[0].to_f
      	y = line[1].to_f
      	z = line[2].to_f


        if x.zero? || y.zero? || z.zero?
          i+=1
          puts "#{i} Error: You gave me a letter or zero"
        else
          group = Sketchup.active_model.active_entities.add_group
          entities = group.entities
          points = [
            Geom::Point3d.new(0, 0, 0),
            Geom::Point3d.new(x, 0, 0),
            Geom::Point3d.new(x, y, 0),
            Geom::Point3d.new(0, y, 0)
          ]
          face = entities.add_face(points)

          face.pushpull(z * -1)
        	# ...
          i+=1
          puts "#{i} Done: #{x}, #{y}, #{z}"
        end


      end

      model.commit_operation
    end


    unless file_loaded?(__FILE__)
      menu = UI.menu('Plugins')
      menu.add_item('CEM Create Cube Example') {
        self.create_cube
      }
      menu.add_item('CEM Import CSV') {
        self.import_cubes
      }

      file_loaded(__FILE__)
    end

  end # module CSVCubes
end # module CEM