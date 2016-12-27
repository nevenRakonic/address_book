class AddFieldsToContact < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :first_name, :string
    add_column :contacts, :last_name, :string
    add_column :contacts, :address, :string
    add_column :contacts, :fixed_phone, :string
    add_column :contacts, :mobile_phone, :string
  end
end
