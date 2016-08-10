class CreateAutoraisetickets < ActiveRecord::Migration
  def change
    create_table :autoraisetickets do |t|
      t.integer :tracker_id, :null => false, :default => 0
      t.string :relation, :null => false, :default => 'relates'
      t.string :subject_before, :null => false, :default => 'subject_before'
      t.string :subject_after, :null => false, :default => 'subject_after'
      t.integer :status_before, :null => false, :default => 0
      t.integer :status_after, :null => false, :default => 0
      t.integer :relation_tracker_id, :null => false, :default => 0
      t.string :some_commnets
    end
  end
end
