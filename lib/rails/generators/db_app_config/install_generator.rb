require 'rails/generators/active_record'

module DbAppConfig
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      desc 'Creates AppConfig model and migration files'

      def self.source_root
        File.expand_path("../templates", __FILE__)
      end

      def self.next_migration_number(dirname)
        ActiveRecord::Generators::Base.next_migration_number(dirname)
      end

      def create_model_file
        template "app_config.rb", "app/models/app_config.rb", 'what'
        migration_template "create_app_configs.rb", "db/migrate/create_app_configs.rb"
      end
    end
  end
end
