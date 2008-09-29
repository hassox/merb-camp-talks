module BlogSlice
  class Posts < Application
    
    def publish
      @post = Post.first(:permalink => params[:permalink])
      if @post.publish!
        redirect slice_url(:post, @post), :message => "Posts Published"
      else
        render :edit
      end
    end
    
  end # Posts
end # BlogSlice