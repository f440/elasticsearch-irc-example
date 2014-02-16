task :default => "setup:all"

VENDOR_DIR_PATH = File.expand_path('../vendor', __FILE__)
ES_VERSION = "1.0.0"
KIBANA_VERSION = "3.0.0milestone5"

task :prepare do
  mkdir_p VENDOR_DIR_PATH
end

namespace :download do
  desc "Download ElasticSearch"
  task :elasticsearch => :prepare do
    filename = "elasticsearch-#{ES_VERSION}.tar.gz"
    filepath = File.join(VENDOR_DIR_PATH, filename)
    fileurl = "https://download.elasticsearch.org/elasticsearch/elasticsearch/#{filename}"

    if File.exists? filepath
      puts "#{filename} already exist."
      next
    end

    sh "curl -L -o #{filepath} #{fileurl}"
  end

  desc "Download Kibana"
  task :kibana => :prepare do
    filename = "kibana-#{KIBANA_VERSION}.tar.gz"
    filepath = File.join(VENDOR_DIR_PATH, filename)
    fileurl = "https://download.elasticsearch.org/kibana/kibana/#{filename}"

    if File.exists? filepath
      puts "#{filename} already exist."
      next
    end

    sh "curl -L -o #{filepath} #{fileurl}"
  end
end

namespace :setup do
  desc "Setup all"
  task :all => ["setup:elasticsearch", "setup:kibana"]

  desc "Setup ElasticSearch"
  task :elasticsearch => "download:elasticsearch" do
    filename = "elasticsearch-#{ES_VERSION}.tar.gz"
    filepath = File.join(VENDOR_DIR_PATH, filename)

    dirname = "elasticsearch"
    dirpath = File.join(VENDOR_DIR_PATH, dirname)

    mkdir_p dirpath
    sh "tar --strip 1 -xf #{filepath} -C #{dirpath}"
  end

  desc "Setup Kibana"
  task :kibana => "download:kibana" do
    filename = "kibana-#{KIBANA_VERSION}.tar.gz"
    filepath = File.join(VENDOR_DIR_PATH, filename)

    dirname = "kibana"
    dirpath = File.join(VENDOR_DIR_PATH, dirname)

    mkdir_p dirpath
    sh "tar --strip 1 -xf #{filepath} -C #{dirpath}"

    ln_sf "../../../../config/kibana.json",  "#{dirpath}/app/dashboards/irc.json"
  end
end
