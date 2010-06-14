Sequel.migration do
  up do
    create_table :users do
      primary_key :id

      String :username,   :null => false
      String :password,   :null => false, :length => 40

      Time :created_at
      Time :updated_at
    end
  end

  down do
    drop_table :users
  end
end
