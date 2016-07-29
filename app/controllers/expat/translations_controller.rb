require_dependency 'expat/application_controller'

module Expat
  class TranslationsController < ApplicationController
    before_action :load_translations

    def index
    end

    def edit
      @translation = @translations[params[:id]]
    end

    def update
      @translations[params[:id]] = params[:value]
      redirect_to locale_translations_path(@locale)
      save_translations
    end

    protected

    def load_translations
      @locale = params[:locale_id]
      path = "#{Rails.root}/config/locales/#{@locale}.yml"
      yml = YAML.load_file path
      @translations = iterate yml[@locale], ''
    end

    def save_translations
      path = "#{Rails.root}/config/locales/#{@locale}.yml"
      File.write path, { @locale => @translations }.to_yaml
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
