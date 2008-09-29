module BlogSlice
  class Posts < BlogSlice::Application
    before :post_by_permalink, :only => [:show, :edit, :update, :destroy, :delete]
  
    def index
      @posts = Post.all
      display @posts
    end
    
    def show
      display @post
    end
    
    def new 
      only_provides :html
      @post = Post.new(params[:post])
      render
    end
    
    def edit 
      only_provides :html
      display @post
    end
    
    def update
      if @post.update_attributes(params[:post])
        redirect slice_url(:post, @post), :message => "Post has been updated"
      else
        render :edit
      end
    end
    
    
    def create
      @post = Post.new(params[:post])
      if @post.save
        redirect slice_url(:post, @post), "Post has been created"
      else
        render :new
      end
    end
    
    def delete
      display @post
    end
    
    def destroy 
      @post.destroy
      redirect slice_url(:posts), :message => "Post has been deleted"
    end
      
    private 
    def post_by_permalink
      @post = Post.first(:permalink => params[:permalink])
      raise NotFound unless @post
      @post
    end
    
  
  end # Posts
end # BlogSlice