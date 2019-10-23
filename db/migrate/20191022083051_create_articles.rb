# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :summary
      t.text :content
      t.integer :visit_times, default: 0

      t.timestamps
    end
  end
end
