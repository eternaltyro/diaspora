# frozen_string_literal: true

# IMPORTANT: This file is generated by cucumber-rails - edit at your own peril.
# It is recommended to regenerate this file in the future when you upgrade to a
# newer version of cucumber-rails. Consider adding your own code to a new file
# instead of editing this one. Cucumber will automatically load all features/**/*.rb
# files.

require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
  def with_scope(locator)
    if locator
      within(locator, match: :first) do
        yield
      end
    else
      yield
    end
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  navigate_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  navigate_to(page_name)
end

When /^(?:|I )press "([^"]*)"(?: within "([^"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

When /^(?:|I )follow "([^"]*)"(?: within "([^"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^(?:|I )fill in "([^"]*)" (?:for|with) "([^"]*)"(?: within "([^"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following(?: within "([^"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |name, value|
      step %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"(?: within "([^"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

When /^(?:|I )check "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When /^(?:|I )uncheck "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    uncheck(field)
  end
end

When /^(?:|I )choose "([^"]*)"(?: within "([^"]*)")?$/ do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

When /^(?:|I )attach the file "([^"]*)" to (?:hidden )?"([^"]*)"(?: within "([^"]*)")?$/ do |path, field, selector|
  with_scope(selector) do
    attach_file(field, Rails.root.join(path).to_s, make_visible: true)
  end
  # wait for the image to be ready
  page.assert_selector(".loading", count: 0)
end

Then /^(?:|I )should see (\".+?\"[\s]*)(?:[\s]+within[\s]* "([^"]*)")?$/ do |vars, selector|
  vars.scan(/"([^"]+?)"/).flatten.each do |text|
    with_scope(selector) do
      current_scope.should have_content(text)
    end
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    page.should have_xpath('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see (\".+?\"[\s]*)(?:[\s]+within[\s]* "([^"]*)")?$/ do |vars,selector|
  vars.scan(/"([^"]+?)"/).flatten.each do |text|
    with_scope(selector) do
      page.should have_no_content(text)
    end
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    page.should have_no_xpath('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within "([^"]*)")? should contain "([^"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    field_value.should =~ /#{value}/
  end
end

Then /^the "([^"]*)" field(?: within "([^"]*)")? should not contain "([^"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    field_value.should_not =~ /#{value}/
  end
end

Then /^the "([^"]*)" checkbox(?: within "([^"]*)")? should be checked$/ do |label, selector|
  with_scope(selector) do
    expect(find_field(label)["checked"]).to be_truthy
  end
end

Then /^the "([^"]*)" checkbox(?: within "([^"]*)")? should not be checked$/ do |label, selector|
  with_scope(selector) do
    expect(find_field(label)["checked"]).to be_falsey
  end
end

Then /^"([^"]*)" should be selected from "([^"]*)"(?: within "([^"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    expect(page).to have_select(field, selected: value)
  end
end

Then /^the "([^"]*)" bootstrap-switch should be (on|off)$/ do |label, state|
  if state == "on"
    expect(page.evaluate_script("$('#{label}').bootstrapSwitch('state')")).to be_truthy
  else
    expect(page.evaluate_script("$('#{label}').bootstrapSwitch('state')")).to be_falsey
  end
end

Then /^I toggle the "#([^"]*)" bootstrap-switch$/ do |id|
  find(".bootstrap-switch-id-#{id}").click
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  confirm_on_page(page_name)
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}
  actual_params.should == expected_params
end

Then /^show me the page$/ do
  save_and_open_page
end

Then /^I wait until ajax requests finished$/ do
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until page.evaluate_script("jQuery.active") == 0
  end
end

When /^I scroll to "([^"]*)"$/ do |element_id|
  element = find_by_id(element_id) # rubocop:disable Rails/DynamicFindBy
  page.scroll_to(element, align: :bottom)
end
