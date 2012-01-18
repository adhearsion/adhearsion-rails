module Adhearsion
  module Rails
    class Plugin
      class Service

        class << self

          ##
          # Start the service
          def start
            if File.directory?(rails_path)
              load_rails

              if defined? ActiveRecord
                # You may need to uncomment the following line for older versions of ActiveRecord
                # ActiveRecord::Base.allow_concurrency = true
                Adhearsion::Events.register_callback :before_call do
                  ActiveRecord::Base.verify_active_connections!
                end
              end
            else
              msg = "Unable to load Rails. Invalid rails root path: #{rails_path.inspect}."
              logger.fatal msg
              raise msg
            end
          end

          ##
          # Loads the Rails environment
          def load_rails
            environment_file = File.expand_path("#{rails_path}/config/environment.rb")
            raise "There is no config/environment.rb file!" unless File.exists?(environment_file)
            if config.environment.nil? || config.environment.to_s.empty?
              msg = "Unable to load Rails. Unexpected nil environment."
              logger.fatal msg
              raise msg
            end
            ENV['RAILS_ENV'] = config.environment.to_s
            load_env_file environment_file
            logger.info "Rails loaded"
          end

          def load_env_file file
            require file
          end

          ##
          # Access to Rails plugin configuration
          def config
            @config ||= Adhearsion.config[:adhearsion_rails]
          end

          ##
          # Returns the absolute Rails root path based on the path config value
          #
          # i.e.
          #     Adhearsion.config[:adhearsion_rails].path = "/foo/bar/../bazz"
          #     puts Adhearsion::Rails::Plugin::Service.rails_path => "/foo/bazz"
          def rails_path
            File.expand_path(config.path)
          end

        end
      end
    end
  end
end
