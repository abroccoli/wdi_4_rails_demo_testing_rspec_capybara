require 'rails_helper'


RSpec.describe Comment do
  describe '.create' do
    it 'creates a new comment on an article' do
      article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
      comment = Comment.create!(body: 'dis be good', article: article)
      expect(comment).to be_a Comment
      expect(comment.article).to be_a Article
    end

    it 'is invalid without a body'do
      expect(Comment.create(body: nil)).not_to be_valid
    end
  end
end
