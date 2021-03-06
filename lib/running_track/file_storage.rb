require 'yaml'

module RunningTrack
  class FileStorage
    class << self
      def yaml_save(tracks_list)
        File.open('./tmp/test.yml', 'w') { |f| f.write tracks_list.to_yaml }
      end

      def yaml_load
        YAML.safe_load(File.open('./tmp/test.yml'), [RunningTrack::Track])
      end
    end
  end
end
