# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Homepage' do
  before do
    unless @browser
<<<<<<< HEAD
      @headless = Headless.new
      @headless.start
=======
      #CodePraise::ApiGateway.new.delete_all_repos
      #@headless = Headless.new
>>>>>>> rebase conflics resolved
      @browser = Watir::Browser.new
    end
  end

  after do
    @browser.close
<<<<<<< HEAD
    @headless.destroy
=======
  #  @headless.destroy
>>>>>>> rebase conflics resolved
  end

  describe 'NEW Homepage' do
    it '(HAPPY) should see home content' do
      # GIVEN: user is on the home page without any projects
      @browser.goto homepage

      # THEN: user should see basic headers, no projects and a welcome message
      _(@browser.h1(id: 'main_header').text).must_equal 'TranslateThis'
      _(@browser.file_field(name: 'img').visible?).must_equal true
      _(@browser.select_list(name: 'target_lang').visible?).must_equal true
      _(@browser.button(text: 'Translate This!').visible?).must_equal true
<<<<<<< HEAD
=======

      #_(@browser.div(id: 'flash_bar_success').visible?).must_equal true #TODO uncomment this after flashbar is done
      #_(@browser.div(id: 'flash_bar_success').text).must_include 'something' #TODO uncomment this after flashbar is done
>>>>>>> rebase conflics resolved
    end
  end

  describe 'Translate an image!' do
    it '(HAPPY) should allow image posting' do
      # GIVEN: user is on the home page
      @browser.goto homepage

      # WHEN: user enters an invalid file type
      @browser.file_field(:name, 'img').set(IMAGE)
      @browser.select_list(:name, 'target_lang').option(:value, 'es').select
      @browser.button(:text, 'Translate This!').click
<<<<<<< HEAD
      # THEN: user should see their new translation
      _(@browser.div(id: 'flash_bar_success').visible?).must_equal true
      _(@browser.div(id: 'flash_bar_success').text)
        .must_include 'Translate Sucess'
      # TODO: add more checks to reflect updated ui
=======
      # _(@browser.div(id: 'flash_bar_success').text).must_include 'Translate This Success' # TODO: include when flash done
      # _(@browser.div(id: 'flash_bar_danger').exists?).must_equal false # TODO: include when flash done

      # THEN: user should see their new translation
      _@browser.html.must_include 'Your picture was recognized'
      # TODO: change to reflect updated ui
>>>>>>> rebase conflics resolved
    end

    it '(BAD) should not accept incorrect filetype' do
      # GIVEN: user is on the home page
      @browser.goto homepage
<<<<<<< HEAD
      # WHEN: user enters an invalid URL
      @browser.file_field(:name, 'img').set(BADFILE)
      @browser.select_list(:name, 'target_lang').option(:value, 'es').select
      @browser.button(:text, 'Translate This!').click
      # THEN: user should see an error alert and no table of repos
      _(@browser.div(id: 'flash_bar_danger').text)
        .must_include 'Failure("No image found")'
      _(@browser.div(id: 'flash_bar_danger').exists?).must_equal true
=======

      # WHEN: user enters an invalid URL
      @browser.file_field(:name, 'img').set(BADFILE)
      @browser.select_list(:name,'target_lang').option(:value, 'es').select
      @browser.button(:text, 'Translate This!').click

      # THEN: user should see an error alert and no table of repos
      _(@browser.div(id: 'flash_bar_danger').text).must_include 'Invalid'
>>>>>>> rebase conflics resolved
    end
  end
end
