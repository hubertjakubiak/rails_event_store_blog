class CreatePost
  attr_reader :post_id, :title, :body, :error

  def initialize(post_id:, title:, body:)
    @post_id = post_id
    @title = title
    @body = body
    @success = false
  end

  def call
    post = PostAggregate.new(post_id)
    post.create(title: title, body: body)
    @success = true
  rescue StandardError => e
    @error = e.message
    @success = false
  end

  def success?
    @success
  end
end
