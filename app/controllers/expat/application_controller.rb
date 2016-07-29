module Expat
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    protected

    def list_locales
      locales = []

      Dir.open("#{Rails.root}/config/locales").each do |file|
        unless ['.', '..'].include?(file) || file[0] == '.'
          locales << file[0...-4] # strip of .yml
        end
      end

      locales
    end
  end
end
