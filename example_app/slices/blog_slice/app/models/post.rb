module BlogSlice
  class Post
    
    property :published, Boolean
    property :published_at, DateTime
    
    def publish!
      self.published = true
      self.published_at = DateTime.now
      save
    end
    
  end # Post
end # BlogSlice