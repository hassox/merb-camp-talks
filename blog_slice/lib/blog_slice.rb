if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  load_dependency 'merb-slices'
  Merb::Plugins.add_rakefiles "blog_slice/merbtasks", "blog_slice/slicetasks", "blog_slice/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  require 'dm-timestamps'
  require 'dm-types'
  
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :blog_slice
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:blog_slice][:layout] ||= :blog_slice
  
  # All Slice code is expected to be namespaced inside a module
  module BlogSlice
    
    # Slice metadata
    self.description = "An example of Merb Slices... In Blog Form"
    self.version = "0.1.0"
    self.author = "Daniel Neighman"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(BlogSlice)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :blog_slice_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      # identify Post => :permalink do
        scope.resource :posts
      # end
    end
    
  end
  
  # Setup the slice layout for BlogSlice
  #
  # Use BlogSlice.push_path and BlogSlice.push_app_path
  # to set paths to blog_slice-level and app-level paths. Example:
  #
  # BlogSlice.push_path(:application, BlogSlice.root)
  # BlogSlice.push_app_path(:application, Merb.root / 'slices' / 'blog_slice')
  # ...
  #
  # Any component path that hasn't been set will default to BlogSlice.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  BlogSlice.setup_default_structure!
  
  # Add dependencies for other BlogSlice classes below. Example:
  # dependency "blog_slice/other"
  
end