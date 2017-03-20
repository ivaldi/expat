module Expat
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception

    before_action :authenticate_expat_user

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

    def authenticate_expat_user
      if methods.include?(:expat_user) && expat_user.nil?
        render text: 'unauthorized'
      end
    end
  end
end
