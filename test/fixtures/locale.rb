require 'i18n'

class I18n::Backend::Simple
  def translations_store
    translations
  end
end

I18n.enforce_available_locales = false

I18n.backend.translations_store[:en] = {
  activerecord: {
    attributes: {
      ar_user: {
        first_name: 'First',
        last_name: 'Last'
      }
    }
  }
}
