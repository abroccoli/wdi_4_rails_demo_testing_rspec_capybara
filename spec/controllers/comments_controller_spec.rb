require 'rails_helper'

RSpec.describe CommentsController do
    let(:valid_attributes) {
    { title: 'One Stupid Trick', body: "You won't believe what happens next..." }
  }

    let(:invalid_attributes) {
    { title: nil, body: nil }
  }

    let(:valid_comment){
      {body: "yeah valid brah"}
    }

    let(:invalid_comment){
      {body: nil}
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

  describe 'GET new' do
    it 'has a 200 status code' do
      article = Article.create!(valid_attributes)
      get :new, article_id: article.id
      expect(response.status).to eq 200
    end

    it 'renders the new template' do
      article = Article.create!(valid_attributes)
      get :new, article_id: article.id
      expect(response).to render_template('new')
    end

    it 'assigns @comment' do
      article = Article.create!(valid_attributes)
      comments = article.comments
      get :new, article_id: article.id
      expect(assigns(:comment)).to be_a_new Comment
    end
  end

    describe 'POST create' do
      context 'with valid attributes' do
        it 'saves a new comment' do
          article = Article.create!(valid_attributes)
          expect {
            post :create, comment: valid_comment, article_id: article.id
          }.to change(Comment, :count).by 1
        end

        it 'assigns @comment' do
          article = Article.create!(valid_attributes)
          post :create, comment: valid_comment, article_id: article.id
          expect(assigns(:comment)).to be_a Comment
          expect(assigns(:comment)).to be_persisted
        end

        it 'redirects to the created article' do
          article = Article.create!(valid_attributes)
          post :create, comment: valid_comment, article_id: article.id
          expect(response).to redirect_to(article_comments_path(article))
        end
      end

      context 'with invalid attributes' do
        it 'assigns @comment, but doesnt not save a new comment' do
          article = Article.create!(valid_attributes)
          post :create, comment: invalid_comment, article_id: article.id
          expect(assigns(:comment)).to be_a Comment
        end

        it 're-renders the new template' do
          article = Article.create!(valid_attributes)
          post :create, comment: invalid_comment, article_id: article.id
          expect(response).to render_template 'new'
        end
      end
    end
end
