class AssociateUserAndContact < ActiveRecord::Migration[5.0]
  def change
    add_reference :contacts, :user, index: true
  end
end
