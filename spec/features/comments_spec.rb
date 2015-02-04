require 'rails_helper'

RSpec.feature 'Managing Comments' do
  scenario 'List all Comments for an Article'do
  article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
  Comment.create!(body: 'dis be good', article: article)

  visit "/articles/#{article.id}/comments"

  expect(page).to have_content 'Comments'
  expect(page).to have_selector 'li.comment'

  end

  scenario 'Create a comment'
  end
end
