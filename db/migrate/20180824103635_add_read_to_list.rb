class AddReadToList < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :read, :integer
  end
end
