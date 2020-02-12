class CreateContests < ActiveRecord::Migration[6.0]
  def change
    create_table :contests do |t|
      t.string :name
      t.bigint :start_epoch_second
      t.bigint :duration_second
      t.text :title
      t.string :rate_change

      t.timestamps
    end

    # コンテスト名を高速に検索するためインデックスの付与
  end
end
