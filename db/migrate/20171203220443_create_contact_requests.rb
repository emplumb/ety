class CreateContactRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_requests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
