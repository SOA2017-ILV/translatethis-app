# frozen_string_literal: true

class HomePage
  include PageObject

  page_url TranslateThis::App.config.APP_URL

  file_field(:image_field, name: 'img')
  select_list(:lang_field, name: 'target_lang')
  button(:translatethis, id: 'repo-form-submit')

  # TODO: create object for returned translation listing.

  def upload_for_translation(img_file, target_lang)
    self.image_field = img_file
    self.lang_field = target_lang
    self.translatethis
  end

  # TODO: create functions to iterate and check validity
  # TODO: create yaml file with expected values for comparision
end
