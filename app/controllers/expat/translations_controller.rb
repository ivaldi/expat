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
      save_translations
      redirect_to locale_translations_path(@locale)
    end

    def new
    end

    def create
      @translations[params[:key]] = params[:value]
      save_translations
      redirect_to locale_translations_path(@locale)
    end

    def destroy
      @translations.delete params[:id]
      save_translations
      redirect_to locale_translations_path(@locale)
    end

    protected

    def load_translations
      @locale = params[:locale_id]
      @translations = load_translation @locale
    end

    def load_translation locale
      path = "#{Rails.root}/config/locales/#{locale}.yml"
      yml = YAML.load_file path
      iterate yml[locale], ''
    end

    def save_translations
      path = "#{Rails.root}/config/locales/#{@locale}.yml"
      result = {}

      @translations.each do |key, value|
        key_parts = key.split('.')

        current = result
        last_key = nil
        level = 0
        key_parts.each do |part|
          unless current[part].present?
            current[part] = {}
          end
          if level < key_parts.count - 1
            current = current[part]
          else
            last_key = part
          end
          level += 1
        end
        current[last_key] = value
      end

      File.write path, { @locale => result }.to_yaml
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
