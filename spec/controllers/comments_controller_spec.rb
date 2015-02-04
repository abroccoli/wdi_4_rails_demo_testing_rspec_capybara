require 'rails_helper'

RSpec.describe CommentsController do
    let(:valid_attributes) {
    { title: 'One Stupid Trick', body: "You won't believe what happens next..." }
  }

    let(:invalid_attributes) {
    { title: nil, body: nil }
  }

  describe 'GET index' do
    it 'has a 200 status code' do
      article = Article.create!(valid_attributes)
      get :index, article_id: article.id
      expect(response.status).to eq 200
    end

    it 'renders the index template' do
      article = Article.create!(valid_attributes)
      get :index, article_id: article.id
      expect(response).to render_template('index')
    end

    it 'assigns @comments' do
      article = Article.create!(valid_attributes)
      comments = article.comments
      get :index, article_id: article.id
      expect(assigns(:comments)).to eq comments
    end

  end


end
