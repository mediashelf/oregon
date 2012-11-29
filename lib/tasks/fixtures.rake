desc 'Load fixtures'
task :fixtures => :environment do
  # TODO: build into generic method/class/other
  require 'rdf/ntriples'
  last_subject = nil

  directory_path = File.expand_path('../../../spec/fixtures', __FILE__)
  Dir.glob(directory_path + '/*.nt') do |path|
    $stderr.puts "Loading file #{path.inspect}"
    RDF::Reader.open(path) do |reader|
      reader.each_statement do |statement|
        if last_subject != statement.subject
          @image.save! if @image
          last_subject = statement.subject

          pid = statement.subject.to_s.split('/').last.to_i
          pid = "oregon:#{pid}"
          $stderr.puts "Creating #{pid.inspect}"

          @image = Image.new(pid: pid)
          @image.read_groups = ["public"]
        end

        @image.descMetadata.set_value(statement.predicate, statement.object.to_s)
      end
    end
  end

  @image.save! if @image

  # Manually load a braceros object's images
  @image = Image.find('oregon:61')
  @image.add_file_datastream(File.open(File.expand_path("../../../spec/fixtures/P0120_2567.tif", __FILE__), "rb").read,
      dsid: "content", mimeType: "image/tiff", label: "P0120_2567.tif")
  @image.add_file_datastream(File.open(File.expand_path("../../../spec/fixtures/P0120_2567.jpg", __FILE__), "rb").read,
      dsid: "thumbnail", mimeType: "image/jpeg", label: "P0120_2567.jpg")
  @image.save

  # This is done manually since we are adding filestreams without updating metadata
  @image.update_index
end
