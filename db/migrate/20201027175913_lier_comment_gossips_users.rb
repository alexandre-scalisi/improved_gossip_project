class LierCommentGossipsUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, index: true
    add_reference :comments, :gossip, index: true
    add_reference :likes, :gossip
    add_reference :likes, :comment
  end
end
