require 'rails_helper'

RSpec.feature 'Managing Comments' do
  scenario 'List all Comments for an Article'do
    article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    Comment.create!(body: 'dis be good', article: article)

    visit "/articles/#{article.id}/comments"

    expect(page).to have_content 'Comments'
    expect(page).to have_selector 'li.comment'

  end

  scenario 'Create a comment' do
    article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")

    visit "/articles/#{article.id}/comments/new"

    fill_in 'Body', with: 'dis be good'

    click_on 'Create Comment'

    expect(page).to have_content(/success/i)
  end

  scenario 'Edit a comment' do
    article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    comment = Comment.create!(body: 'dis be good', article: article)

    visit "/articles/#{article.id}/comments/#{comment.id}/edit"

    fill_in 'Body', with: 'dis also be good'

    click_on 'Update Comment'

    expect(page).to have_content(/success/i)
    expect(page).to have_content 'dis also be good'

  end


end
