class MakeTagsImportant < ActiveRecord::Migration
  def change
    execute "
    UPDATE `tags` SET `tags`.`important` = 1 WHERE `tags`.`tag` IN ('Beginner', 'Intermediate', 'Advanced')
    "


  end
end
