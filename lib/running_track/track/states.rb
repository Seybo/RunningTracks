require 'aasm'

module RunningTrack
  class Track
    include AASM

    module States
      def self.included(receiver)
        receiver.aasm do
          state :unknown, initial: true
          state :good, :normal, :bad

          event :good do
            transitions from: :unknown, to: :good
          end

          event :normal do
            transitions from: :unknown, to: :normal
          end

          event :bad do
            transitions from: :unknown, to: :bad
          end
        end
      end
    end
  end
end
