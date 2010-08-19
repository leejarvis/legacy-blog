Sequel.migration do
  up do
    create_table :users do
      primary_key :id

      String :username, :null => false, :unique => true
      String :password, :null => false, :length => 40

      Time :created_at
      Time :updated_at
    end

    create_table :posts do
      primary_key :id

      String :title,  :null => false
      String :body,   :null => false, :text => true

      Integer :draft,     :null => false, :default => 0 
      
      Time :created_at
      Time :updated_at

      foreign_key :user_id, :users
    end

    create_table :tags do
      primary_key :id

      String :name
    end

    create_table :post_tags do
      foreign_key :post_id, :posts
      foreign_key :tag_id,  :tags
    end
  end

  down do
    drop_table :users, :posts, :tags, :post_tags
  end
end
