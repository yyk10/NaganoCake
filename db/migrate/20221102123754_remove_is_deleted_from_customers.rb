class RemoveIsDeletedFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :is_eleted, :boolean
  end
end
