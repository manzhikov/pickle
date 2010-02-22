# this file generated by script/generate pickle email
#
# add email mappings in features/support/email.rb

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true

Before do
  ActionMailer::Base.deliveries.clear
end

# Clear the deliveries array, useful if your background sends email that you want to ignore
Given(/^all emails? (?:have|has) been delivered$/) do
  ActionMailer::Base.deliveries.clear
end

Given(/^(\d)+ emails? should be delivered$/) do |count|
  emails.size.should == count.to_i
end

When(/^(?:I|they) follow "([^"]*?)" in #{capture_email}$/) do |link, email_ref|
  visit_in_email(email(email_ref), link)
end

When(/^(?:I|they) click the first link in #{capture_email}$/) do
  click_first_link_in_email(email(email_ref))
end

Then(/^(\d)+ emails? should be delivered to (.*)$/) do |count, to|
  emails("to: \"#{email_for(to)}\"").size.should == count.to_i
end

Then(/^(\d)+ emails? should be delivered with #{capture_fields}$/) do |count, fields|
  emails(fields).size.should == count.to_i
end

Then(/^#{capture_email} should be delivered to (.+)$/) do |email_ref, to|
  email(email_ref, "to: \"#{email_for(to)}\"").should_not be_nil
end

Then(/^#{capture_email} should not be delivered to (.+)$/) do |email_ref, to|
  email(email_ref, "to: \"#{email_for(to)}\"").should be_nil
end

Then(/^#{capture_email} should have #{capture_fields}$/) do |email_ref, fields|
  email(email_ref, fields).should_not be_nil
end

Then(/^#{capture_email} should contain "(.*)"$/) do |email_ref, text|
  email(email_ref).body.should =~ /#{text}/
end

Then(/^#{capture_email} should not contain "(.*)"$/) do |email_ref, text|
  email(email_ref).body.should_not =~ /#{text}/
end

Then(/^#{capture_email} should link to (.+)$/) do |email_ref, page|
  email(email_ref).body.should =~ /#{path_to(page)}/
end

Then(/^show me the emails?$/) do
   save_and_open_emails
end