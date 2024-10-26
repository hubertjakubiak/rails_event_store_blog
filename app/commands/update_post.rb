class UpdatePost
  attr_reader :post_id, :title, :body

  def initialize(post_id:, title:, body:)
    @post_id = post_id
    @title = title
    @body = body
  end

  def call
    post = PostAggregate.new(post_id)
    post.update(title: title, body: body)
  end
end
