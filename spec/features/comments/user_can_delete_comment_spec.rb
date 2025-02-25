require 'rails_helper'

RSpec.feature 'Timeline', type: :feature do
  scenario 'Can delete comments' do
    sign_in
    post = create_post('a post')
    create_comment('This is a comment', post.id)
    visit('/posts')

    click_button 'Delete Comment'

    expect(page).not_to have_content('This is a comment')
  end

  scenario 'Can delete comments' do
    sign_in
    post = create_post('a post')
    create_comment('This is a comment', post.id)
    visit('/posts')
    click_button 'Delete Comment'

    expect(page).to have_content('Delete successful')
  end
end
