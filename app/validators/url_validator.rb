class UrlValidator < ActiveModel::EachValidator
  URL_REGEX = /\A#{URI.regexp(%w[http https])}\z/
  
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || I18n.t('link.invalid')) unless
      value =~ URL_REGEX
  end
end
