require File.dirname(__FILE__) + '/../spec_helper'

describe "BlogSlice::Main (controller)" do
  
  # Feel free to remove the specs below
  
  before :all do
    Merb::Router.prepare do 
      add_slice(:BlogSlice)
    end if standalone?
  end
  
  after :all do
    Merb::Router.reset! if standalone?
  end
  
  it "should have access to the slice module" do
    controller = dispatch_to(BlogSlice::Main, :index)
    controller.slice.should == BlogSlice
    controller.slice.should == BlogSlice::Main.slice
  end
  
  it "should have an index action" do
    controller = dispatch_to(BlogSlice::Main, :index)
    controller.status.should == 200
    controller.body.should contain('BlogSlice')
  end
  
  it "should work with the default route" do
    controller = get("/blog_slice/main/index")
    controller.should be_kind_of(BlogSlice::Main)
    controller.action_name.should == 'index'
  end
  
  it "should work with the example named route" do
    controller = get("/blog_slice/index.html")
    controller.should be_kind_of(BlogSlice::Main)
    controller.action_name.should == 'index'
  end
    
  it "should have a slice_url helper method for slice-specific routes" do
    controller = dispatch_to(BlogSlice::Main, 'index')
    
    url = controller.url(:blog_slice_default, :controller => 'main', :action => 'show', :format => 'html')
    url.should == "/blog_slice/main/show.html"
    controller.slice_url(:controller => 'main', :action => 'show', :format => 'html').should == url
    
    url = controller.url(:blog_slice_index, :format => 'html')
    url.should == "/blog_slice/index.html"
    controller.slice_url(:index, :format => 'html').should == url
  end
  
  it "should have helper methods for dealing with public paths" do
    controller = dispatch_to(BlogSlice::Main, :index)
    controller.public_path_for(:image).should == "/slices/blog_slice/images"
    controller.public_path_for(:javascript).should == "/slices/blog_slice/javascripts"
    controller.public_path_for(:stylesheet).should == "/slices/blog_slice/stylesheets"
  end
  
  it "should have a slice-specific _template_root" do
    BlogSlice::Main._template_root.should == BlogSlice.dir_for(:view)
    BlogSlice::Main._template_root.should == BlogSlice::Application._template_root
  end

end