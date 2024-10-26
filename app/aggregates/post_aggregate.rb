# app/aggregates/post.rb
class PostAggregate
  attr_reader :post_id, :title, :body

  def initialize(post_id)
    @post_id = post_id
    @title = nil
    @body = nil
  end

  # Command handler within the aggregate to create a post
  def create(title:, body:)
    # Business rules enforced by the aggregate
    raise 'Title cannot be blank' if title.strip.empty?
    raise 'body cannot be blank' if body.strip.empty?

    # Apply event if validations pass
    apply_event(PostCreated.new(data: { post_id: post_id, title: title, body: body }))
  end

  def update(title:, body:)
    # Business rules enforced by the aggregate
    raise 'Title cannot be blank' if title.strip.empty?
    raise 'body cannot be blank' if body.strip.empty?

    # Apply event if validations pass
    apply_event(PostUpdated.new(data: { post_id: post_id, title: title, body: body }))
  end

  def delete
    apply_event(PostDeleted.new(data: { post_id: post_id }))
  end

  # Apply method to update the aggregate's internal state when an event is applied
  def apply(event)
    case event
    when PostCreated
      @title = event.data[:title]
      @body = event.data[:body]
    when PostUpdated
      @title = event.data[:title]
      @body = event.data[:body]
    end
  end

  private

  # Apply and publish the event to the event store
  def apply_event(event)
    apply(event)  # Update aggregate state
    Rails.configuration.event_store.publish(event, stream_name: stream_name)  # Publish event
  end

  def stream_name
    "Post$#{post_id}"
  end
end
