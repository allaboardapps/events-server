class InitialSetup < ActiveRecord::Migration
  def change
    create_table :events, id: :uuid, force: true do |t|
      t.integer "client_id"
      t.integer "location_id"
      t.string "name"
      t.string "abbreviation"
      t.string "primary_category"
      t.text "categories", array: true, default: []
      t.datetime "starts_at"
      t.datetime "ends_at"
      t.string "description"
      t.string "street_address"
      t.string "secondary_address"
      t.string "city"
      t.string "state"
      t.string "country"
      t.string "zip_code"
      t.string "time_zone"
      t.float "latitude"
      t.float "longitude"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :favorites, id: :uuid, force: true do |t|
      t.integer "user_id"
      t.integer "event_id"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :regions, id: :uuid, force: true do |t|
      t.string "name"
      t.string "abbreviation"
      t.string "time_zone"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end

    create_table :locations, id: :uuid, force: true do |t|
      t.integer "region_id"
      t.string "name"
      t.string "abbreviation"
      t.string "time_zone"
      t.string "admin_notes"
      t.boolean "archived", default: false
      t.boolean "test", default: false
      t.timestamps
    end
  end
end
