class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.string :home_team, null: false
      t.string :away_team, null: false
      t.integer :home_score, null: false, default: 0
      t.integer :away_score, null: false, default: 0
      t.timestamps
    end

    add_index :scores, %i[home_team away_team], unique: true
  end
end
