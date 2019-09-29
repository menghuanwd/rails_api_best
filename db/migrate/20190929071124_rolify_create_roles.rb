# frozen_string_literal: true

class RolifyCreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, polymorphic: true

      t.timestamps
    end

    create_table(:editors_roles, id: false) do |t|
      t.references :editor
      t.references :role
    end

    add_index(:roles, %i[name resource_type resource_id])
    add_index(:editors_roles, %i[editor_id role_id])
  end
end
