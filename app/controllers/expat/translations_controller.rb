require_dependency 'expat/application_controller'

module Expat
  class TranslationsController < ApplicationController
    before_action :load_translations

    def index
    end

    def edit
    end

    def update
    end

    protected

    def load_translations
      path = "#{Rails.root}/config/locales/#{params[:locale_id]}.yml"
      yml = YAML.load_file path
      @translations = iterate yml[params[:locale_id]], ''
    end

    def iterate node, parent, result = {}
      node.each do |k,v|
        if v.respond_to? :each
          iterate node[k], "#{parent}#{k}.", result
        else
          result["#{parent}#{k}"] = v
        end
      end

      result
    end
  end
end
