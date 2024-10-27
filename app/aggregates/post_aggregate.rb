class PostAggregate
  include AggregateRoot

  attr_reader :post_id, :title, :body

  def initialize(post_id)
    @post_id = post_id
    @title = nil
    @body = nil
  end

  def create(title:, body:)
    validate_presence_of(title, body)
    apply_event(PostCreated.new(data: { post_id: post_id, title: title, body: body }))
  end

  def update(title:, body:)
    validate_presence_of(title, body)
    apply_event(PostUpdated.new(data: { post_id: post_id, title: title, body: body }))
  end

  def delete
    apply_event(PostDeleted.new(data: { post_id: post_id }))
  end

  private

  def validate_presence_of(title, body)
    raise "Title is blank" if title.strip.empty?
    raise "Body is blank" if body.strip.empty?
  end

  def apply_post_created(event)
    @title = event.data[:title]
    @body = event.data[:body]
  end

  def apply_post_updated(event)
    @title = event.data[:title]
    @body = event.data[:body]
  end

  def apply_post_deleted(event)
    @title = nil
    @body = nil
  end

  def stream_name
    "Post$#{post_id}"
  end

  def apply_event(event)
    apply(event)
    event_store.publish(event, stream_name: stream_name)
  end

  def event_store
    @event_store ||= Rails.configuration.event_store
  end
end
