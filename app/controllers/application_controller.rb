class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  NOT_FOUND_EXCEPTIONS = [].tap {|exceptions|
    exceptions << ActiveRecord::RecordNotFound if defined? ActiveRecord
    exceptions << AbstractController::ActionNotFound if defined? AbstractController
    exceptions << ActionController::RoutingError if defined? ActionController
    exceptions << ActionController::UnknownController if defined? ActionController
    exceptions << ActionView::MissingTemplate if defined? ActionView
  }

  if Settings.handle_exceptions.nil? || Settings.handle_exceptions
    rescue_from Exception do |exception|

      unless NOT_FOUND_EXCEPTIONS.include?(exception.class)
        render "public/500.html", formats: :html, status: 200, layout: false
      else
        render "public/404.html", formats: :html, status: 200, layout: false
      end
    end
  end
end
