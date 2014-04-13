class CreateAppConfigs < ActiveRecord::Migration
  def change
    create_table :app_configs do |t|
      t.string :name
      t.text :value

      t.timestamps
    end

    add_index :app_configs, :name, unique: true
  end
end
