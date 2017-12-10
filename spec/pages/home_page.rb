# frozen_string_literal: true

class HomePage
  include PageObject

  page_url TranslateThis::App.config.APP_URL

  div(:warning_message, id: 'flash_bar_danger')
  div(:sucess_message, id: 'flash_bar_success')

  h1(:title_heading, id: 'main_header')
  file_field(:image, name: 'img')
  button(:takepic, class: 'btn-default') # TODO: will probably change
  select_list(:lang_field, name: 'target_lang')
  button(:sendrequest, id: 'repo-form-submit')

  h2(:translate_heading, id: 'translate_header')
  div(:translations_table, id: 'accordion')
  a(:firsttranslation, href: '#collapse-0')
  div(:firstorigintxt, id: 'collapse-0')

  img(:tacode, src: '/images/TacodeLogo.png')

  indexed_property(
    :translations,
    [
      [:div, :trans, { id: 'heading-[%s]' }],
      [:div, :origin, { id: 'collapse-[%s]' }]
    ]
  )

  def first_translation
    translations[0]
  end

  def second_translation
    translations[1]
  end

  def upload_and_translate(img_file, target_lang)
    self.image = img_file
    self.lang_field = target_lang
    translatethis
  end

  def num_translations_found
    translations_table.split("\n").size
  end

  def translations_listed
    translations_table.split("\n")
  end

  def first_translation_source_text
    translations[0].translation.a.click
    source = translations[0].origin.text
    source
  end
  # TODO: create yaml file with expected values for comparision
end
