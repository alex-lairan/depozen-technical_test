class CreateUsersContracts < ActiveRecord::Migration[8.0]
  def change
    create_table :users_contracts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
