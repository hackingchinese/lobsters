class ChangeTiers < ActiveRecord::Migration
  def change
    execute 'update tags set tier = 3 where tier = 2'
  end
end
