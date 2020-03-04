module Helpers
  module ControllersHelper
    def parse_response(response)
      JSON.parse response.body
    end
  end
end
