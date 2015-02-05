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

  describe 'GET edit' do
    it 'has a 200 status code' do
      article = Article.create!(valid_attributes)
      comment = Comment.create!(valid_comment)
      article.comments << comment
      get :edit, article_id: article.id, id: comment.id
      expect(response.status).to eq 200
    end

    it 'renders the edit template' do
      article = Article.create!(valid_attributes)
      comment = Comment.create!(valid_comment)
      article.comments << comment
      get :edit, article_id: article.id, id: comment.id
      expect(response).to render_template('edit')
    end

    it 'assigns @article' do
      article = Article.create!(valid_attributes)
      comment = Comment.create!(valid_comment)
      article.comments << comment
      get :edit, article_id: article.id, id: comment.id
      expect(assigns(:comment)).to eq comment
    end
  end

  describe 'PATCH update' do
    context 'with valid attributes'do
           let(:new_attributes) {
          {body: 'yeah valid brah' }
      }

      it 'updates the requested article' do
        article = Article.create!(valid_attributes)
        comment = Comment.create!(valid_comment)
        article.comments << comment
        patch :update, article_id: article.id, id: comment.id, comment: new_attributes
        comment.reload
        expect(comment.body).to eq new_attributes[:body]
      end

      it 'assigns @comment' do
        article = Article.create!(valid_attributes)
        comment = Comment.create!(valid_comment)
        article.comments << comment
        patch :update, article_id: article.id, id: comment.id, comment: new_attributes
        expect(assigns(:comment)).to eq comment
      end

      it 'redirects to the article' do
        article = Article.create!(valid_attributes)
        comment = Comment.create!(valid_comment)
        article.comments << comment
        patch :update, article_id: article.id, id: comment.id, comment: new_attributes
        expect(response).to redirect_to article_comments_path(article)
      end
    end
    context 'with invalid attributes' do
      it 'assigns @comment' do
        article = Article.create!(valid_attributes)
        comment = Comment.create!(valid_comment)
        article.comments << comment
        patch :update, article_id: article.id, id: comment.id, comment: invalid_comment
        expect(assigns(:comment)).to eq comment
      end

      it 're-renders the edit template' do
        article = Article.create!(valid_attributes)
        comment = Comment.create!(valid_comment)
        article.comments << comment
        patch :update, article_id: article.id, id: comment.id, comment: invalid_comment
        expect(assigns(:comment)).to eq comment
        expect(response).to render_template('edit')
      end
    end
  end
end
