class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :title, :null => false
      t.boolean :free_shipping, :null => false, :default => false
      t.timestamps
    end
  end
end
