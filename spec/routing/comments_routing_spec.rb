require 'rails_helper'

RSpec.describe 'routes for comments' do
  it 'routes GET /articles/:id/comments' do
    expect(get('/articles/1/comments')).to route_to(
      controller: 'comments',
      action: 'index',
      article_id: '1'
      )
  end
end

