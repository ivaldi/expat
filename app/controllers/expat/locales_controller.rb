require_dependency 'expat/application_controller'

module Expat
  class LocalesController < ApplicationController
    def index
      @locales = list_locales
    end
  end
end
