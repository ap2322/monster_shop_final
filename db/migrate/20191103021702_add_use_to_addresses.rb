class AddUseToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :use, :integer, default: 0
  end
end
