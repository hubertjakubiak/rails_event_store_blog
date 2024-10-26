class DeletePost
  attr_reader :post_id

  def initialize(post_id:)
    @post_id = post_id
  end

  def call
    post = PostAggregate.new(post_id)
    post.delete
  end
end

