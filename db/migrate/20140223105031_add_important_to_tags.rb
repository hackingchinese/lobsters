class AddImportantToTags < ActiveRecord::Migration
  def change
    add_column :tags, :important, :boolean
    add_index :tags, :important
  end
end
