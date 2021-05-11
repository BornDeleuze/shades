class ApplicationController < ActionController::Base

    def wrong_page
        render "/wrong_page"
    end
end
