require 'rails_helper'

RSpec.describe 'routes for comments' do
  it 'routes GET /articles/:id/comments' do
    expect(get('/articles/1/comments')).to route_to(
      controller: 'comments',
      action: 'index',
      article_id: '1'
      )
  end

  it 'routes GET /articles/:id/comments/new' do
    expect(get('/articles/1/comments/new')).to route_to(
      controller: 'comments',
      action: 'new',
      article_id: '1'
      )
  end

  it 'routes GET /articles/:id/comments/:id/edit to the comments controller and sets id' do
    expect(get('articles/1/comments/1/edit')).to route_to(
      controller: 'comments',
      action: 'edit',
      article_id: '1',
      id: '1'
    )
  end

  it 'routes PATCH /articles/1 to the articles controller and sets id' do
    expect(patch('articles/1/comments/1')).to route_to(
      controller: 'comments',
      action: 'update',
      article_id:'1',
      id: '1'
    )
  end

end

