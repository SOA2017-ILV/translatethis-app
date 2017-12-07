# frozen_string_literal: true

class HomePage
  include PageObject

  page_url TranslateThis::App.config.APP_URL

  div(:warning_message, id: 'flash_bar_danger')
  div(:sucess_message, id: 'flash_bar_success')

  h1(:title_heading, id: 'main_header')
  button(:uploadfile, class: 'btn-upload-file')
  button(:takepic, class: 'btn-default') # TODO: will probably change
  select_list(:lang_field, name: 'target_lang')
  button(:translatethis, id: 'repo-form-submit')

  h2(:translate_heading, id: 'translate_header')
  panel_group(:translations_table, id: 'accordion')

  # TODO: create object for returned translation listing.

  def upload_for_translation(img_file, target_lang)
    self.image_field = img_file
    self.lang_field = target_lang
    self.translatethis
  end

  # TODO: create functions to iterate and check validity
  # TODO: create yaml file with expected values for comparision
end
