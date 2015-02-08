require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

feature "Show tickets index" do

  scenario "for client" do
    visit '/'
    expect(page).to have_content 'Client name'
  end

end


feature "Add ticket and show it for client" do
  
  scenario "by client" do
    visit '/tickets/new'
    
    fill_in 'Client name', with: 'Ivan'
    fill_in 'Client email', with: 'ivan@mail.com'
    fill_in 'Subject', with: 'This my question'
    fill_in 'Body', with: 'I have a little question'
    
    click_button 'Create Ticket'
    
    expect(page).to have_content 'I have a little question'
  end

end


feature "Show ticket for staff" do
  given(:owner) { }
  background(:each) { login_as(owner) }
  after(:each) { Warden.test_reset! }

  scenario "show reply form" do
    visit '/tickets/1'
    expect(page).to have_content 'Add a reply'
  end

  scenario "post reply" do
    visit '/tickets/1'
    fill_in 'Body', with: 'MyReply'
 
    expect(page).to have_content 'MyReply'
  end
end