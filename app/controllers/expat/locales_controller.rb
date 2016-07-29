require_dependency 'expat/application_controller'

module Expat
  class LocalesController < ApplicationController
    def index
      @locales = []

      Dir.open("#{Rails.root}/config/locales").each do |file|
        unless ['.', '..'].include?(file) || file[0] == '.'
          @locales << file[0...-4] # strip of .yml
        end
      end
    end
  end
end
