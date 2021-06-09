class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :users
end
