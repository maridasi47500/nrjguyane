class ApplicationController < ActionController::Base
    def render_not_found
    render :file => "#{Rails.root.to_s}/public/404.html",  :status => 404
  end
end
