require 'sketchup.rb'
require 'extensions.rb'

module CEM
  module CSVCube

    unless file_loaded?(__FILE__)
      ex = SketchupExtension.new('CSV Cube', 'cem_csv_cube/main')
      ex.description = 'SketchUp Ruby API example creating a cube.'
      ex.version     = '1.0.0'
      ex.copyright   = 'CEM © 2016'
      ex.creator     = 'Chris Mills'
      Sketchup.register_extension(ex, true)
      file_loaded(__FILE__)
    end

  end # module CSVCubes
end # module CEM