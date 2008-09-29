module BlogSlice
  class Post
    include DataMapper::Resource
    
    property :id,           Serial
    property :title,        String, :lenth => 255
    property :body,         Text
    property :permalink,    Permalink
    property :created_at,   DateTime
    property :updated_at,   DateTime
    
    before :save do
      self.permalink = self.title unless self.permalink
    end
    
  end # Post
end # BlogSlice