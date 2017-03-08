require_dependency 'expat/application_controller'

module Expat
  class TranslationsController < ApplicationController
    before_action :load_translations

    def index
      @translations = append_missing_translations @locale, @translations
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

    def append_missing_translations current, current_translations
      result = {}

      list_locales.each do |locale|
        next if current == locale

        translation = load_translation locale
        (current_translations.keys | translation.keys).each do |key|
          result[key] = current_translations[key]
        end
      end

      result
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
      unless node.nil?
        node.each do |k,v|
          if v.respond_to? :each
            iterate node[k], "#{parent}#{k}.", result
          else
            result["#{parent}#{k}"] = v
          end
        end
      end

      result
    end
  end
end
