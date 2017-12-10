# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Homepage' do
  before do
    unless @browser
      @headless = Headless.new
      @headless.start
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
    @headless.destroy
  end

  describe 'NEW Homepage' do
    include PageObject::PageFactory
    it '(HAPPY) should see home content' do
      # GIVEN: user is on the home page without translation requests
      visit HomePage do |page|
        # THEN: user should see basic headers and no translations
        _(page.title_heading).must_equal 'TranslateThis'
        _(page.image.text).must_equal ''
        _(page.lang_field).must_equal 'Afrikaans'
        _(page.img(src: '/images/TacodeLogo.png').visible?).must_equal true
      end
    end
  end

  describe 'requesting a translation' do
    include PageObject::PageFactory

    it '(Happy) should allow translation request' do
      # GIVEN: user is on homepage
      visit HomePage do |page|
        # WHEN: user uploads image and selects language for translation.
        page.file_field.set(IMAGE)
        page.lang_field = 'zh-TW'
        page.sendrequest
        page.wait(10)
        # THEN: User will see new translations
        _(page.translate_heading).must_equal 'Translations'
        _(page.translations_listed).must_equal TRA_VAL
        # And be able to interact with the translations
        page.firsttranslation
        _(page.firstorigintxt).must_equal ORI_VAL[0]
      end
    end

    it '(SAD) should not allow incorrect filetype for translation' do
      # GIVEN: user is on HomePage
      visit HomePage do |page|
        # WHEN user provides invalid file type
        page.file_field.set(BADFILE)
        # language select should still be interactable
        page.lang_field = 'zh-TW'
        # THEN: User should not be able to request translation with a bad file
        _(page.button(id: 'repo-form-submit').visible?).must_equal false
      end
    end
  end
end
