require 'shorturl/service'

module ShortURL
  module Services
    class Vamu < Service

      def initialize
        super('va.mu')

        @method = :get
        @action = '/api/create'
      end

    end
  end
end
