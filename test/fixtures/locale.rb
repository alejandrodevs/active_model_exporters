# frozen_string_literal: true

require "i18n"

module I18n
  module Backend
    class Simple
      def translations_store
        translations
      end
    end
  end
end

I18n.enforce_available_locales = false

I18n.backend.translations_store[:en] = {
  activerecord: {
    attributes: {
      ar_user: {
        first_name: "First",
        last_name: "Last"
      }
    }
  }
}
