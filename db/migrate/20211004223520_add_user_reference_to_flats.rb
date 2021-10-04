class AddUserReferenceToFlats < ActiveRecord::Migration[6.0]
  def change
  add_reference :flats, :user, foreign_key: true
  end
end
