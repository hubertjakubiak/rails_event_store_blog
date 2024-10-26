# app/projections/post_projection.rb
class PostProjection
  def call(event)
    case event
    when PostCreated
      create_post(event)
    when PostUpdated
      update_post(event)
    when PostDeleted
      delete_post(event)
    end
  end

  private

  def create_post(event)
    Post.create!(
      id: event.data[:post_id],
      title: event.data[:title],
      body: event.data[:body]
    )
  end

  def update_post(event)
    post = Post.find(event.data[:post_id])
    post.update!(
      title: event.data[:title],
      body: event.data[:body]
    )
  end

  def delete_post(event)
    Post.find(event.data[:post_id]).destroy
  end
end
