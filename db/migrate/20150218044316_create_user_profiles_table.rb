class CreateUserProfilesTable < ActiveRecord::Migration
  def change
    create_table(:user_profiles) do |t|
        t.integer :user_id
        t.string :first_name
        t.string :last_name
        t.string :country
        t.string :bitcoin_address
        t.string :card_type
        t.datetime :expirey_date
        t.string :card_number_last_four
        t.string :favorite_color
        t.string :blog
    end
  end
end
