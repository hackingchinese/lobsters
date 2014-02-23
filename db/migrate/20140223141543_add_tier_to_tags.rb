class AddTierToTags < ActiveRecord::Migration
  def change
    add_column :tags, :tier, :integer, default: 0
  end
end
