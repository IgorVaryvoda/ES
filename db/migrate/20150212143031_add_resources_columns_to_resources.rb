class AddResourcesColumnsToResources < ActiveRecord::Migration
  def self.up
    add_attachment :resources, :document
  end

  def self.down
    remove_attachment :resources, :document
  end
end
