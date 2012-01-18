module Adhearsion
  module Rails

    ##
    # Adhearsion Plugin that defines the Rails configuration options
    # and includes a hook to start the Rails service in Adhearsion initialization process
    class Plugin < Adhearsion::Plugin
      extend ActiveSupport::Autoload

      autoload :Service

      # Default configuration for Rails integration.
      config :adhearsion_rails do
        path "", :desc => "Local path (absolute or relative) where the Rails application is located"
        environment :development, :desc => <<-__
          Identifies the Rails environment. Valid values are:
            - :development
            - :test
            - :production
            - any other environment that you have defined in your rails application
        __
      end

      # Include the RAils service in plugins initialization process
      init :adhearsion_rails do
        Service.start
      end

    end

  end
end
