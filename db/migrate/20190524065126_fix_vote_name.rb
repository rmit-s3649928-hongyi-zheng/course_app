class FixVoteName < ActiveRecord::Migration[5.1]
  def change
    rename_column :votes, :type, :kind
  end
end
