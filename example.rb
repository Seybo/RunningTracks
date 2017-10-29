require_relative 'lib/running_track.rb'

selection = RunningTrack.find_by('district', 'район Крюково')
RunningTrack.save(selection)
RunningTrack.print(selection)

all = RunningTrack.all
RunningTrack.print(all)

loaded = RunningTrack.load
RunningTrack.print(loaded)
