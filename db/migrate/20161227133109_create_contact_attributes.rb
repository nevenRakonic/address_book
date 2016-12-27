class CreateContactAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_attributes do |t|
      t.belongs_to :contact, index: true
      t.string :name
      t.string :content

      t.timestamps
    end
  end
end
