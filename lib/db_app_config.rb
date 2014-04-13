module DbAppConfig
  module AppConfig
    def self.included(base)
      base.extend ClassMethods
    end


    module ClassMethods
      def method_missing(meth, *args, &block)
        meth_s = meth.to_s
        if meth_s =~ /=\z/
          self.create(name: meth_s.sub('=',''), value: args[0])
          reload_cache
        elsif !args.any?
          get_all[meth]
        else
          super
        end
      end

      def get_all
        Rails.cache.fetch(:db_app_config) {generate_list}
      end

      def destroy(sym)
        self.find_by_name(sym).destroy
        reload_cache
      end

      private def reload_cache
        Rails.cache.delete(:db_app_config)
        get_all
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
end
