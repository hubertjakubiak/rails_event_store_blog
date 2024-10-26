class DeletePost
  attr_reader :post_id, :error

  def initialize(post_id:)
    @post_id = post_id
  end

  def call
    post = PostAggregate.new(post_id)
    post.delete
    @success = true
  rescue StandardError => e
    @error = e.message
    @success = false
  end

  def success?
    @success
  end
end

