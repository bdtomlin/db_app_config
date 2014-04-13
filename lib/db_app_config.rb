module DbAppConfig
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def db_app_config
      extend DbAppConfig::ExtendedClassMethods
    end
  end

  module ExtendedClassMethods
    def method_missing(meth, *args, &block)
      meth_s = meth.to_s
      if meth_s =~ /=\z/
        self.create(name: meth_s.sub('=',''), value: args[0])
        Rails.cache.delete(:db_app_config)
      elsif !args.any?
        get_all[meth]
      else
        super
      end
    end

    def get_all
      db_app_config= Rails.cache.fetch(:db_app_config) {generate_list}
    end

    private def generate_list
      db_app_config= {}
      all.each do |setting|
        db_app_config[setting.name.to_sym] = setting.value
      end
      db_app_config
    end
  end
end


ActiveRecord::Base.send :include, DbAppConfig
