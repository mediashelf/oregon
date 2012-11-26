desc 'Load fixtures'
task :fixtures => :environment do
  @image = Image.new(pid: 'oregon:61')
  # path = File.expand_path('../../../spec/fixtures/oregondigital_63.nt', __FILE__)
  # puts path
  #@image.descMetadata.content = File.open(path).read
  @image.type = "Image"
  @image.spatial = "Benton County (Ore.)"
  @image.created = "2004-03-17"
  @image.description = "Mexican workers washing up at a work camp in Benton County"
  @image.rights = "Permission to use must be obtained from OSU Archives."
  @image.title = "Washing up"
  @image.subject = ["Agricultural laborers--Mexican--Oregon", "Agricultural laborers--Housing--Oregon", "Agricultural laborers--Health and hygiene--Oregon"]
  @image.identifier = "P120:2569"
  @image.modified =  "2011-12-19"
  @image.hasFormat = "B&W print"
  @image.date = "1944"

  @image.save

  @image = Image.new(pid: 'oregon:62')
  # path = File.expand_path('../../../spec/fixtures/oregondigital_63.nt', __FILE__)
  # puts path
  #@image.descMetadata.content = File.open(path).read
  @image.type = "Image"
  @image.spatial = "Benton County (Ore.)"
  @image.created = "2004-03-17"
  @image.description = "Mexican workers in Benton County"
  @image.rights = "Permission to use must be obtained from OSU Archives."
  @image.title = "Mexican workers"
  @image.subject = ["Agricultural laborers--Mexican--Oregon", "Agricultural laborers--Housing--Oregon"]
  @image.identifier = "P120:2567"
  @image.modified =  "2011-12-19"
  @image.hasFormat = "B&W print"
  @image.date = "1944"

  @image.save

  @image = Image.new(pid:'oregon:63')
  # path = File.expand_path('../../../spec/fixtures/oregondigital_63.nt', __FILE__)
  # puts path
  #@image.descMetadata.content = File.open(path).read
  @image.type = "Image"
  @image.spatial = "Benton County (Ore.)"
  @image.created = "2004-03-17"
  @image.description = "Mexican workers living quarters"
  @image.rights = "Permission to use must be obtained from OSU Archives."
  @image.title = "Living quarters"
  @image.subject = ["Agricultural laborers--Mexican--Oregon", "Agricultural laborers--Housing--Oregon"]
  @image.identifier = "P120:2570"
  @image.modified =  "2011-12-19"
  @image.hasFormat = "B&W print"
  @image.date = "1944"

  @image.save
end
