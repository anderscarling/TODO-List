class Todo < ActiveRecord::Base
  ##############################################################################
  # Validates
  validates :user_id, presence: true
  validates :note,    presence: true, length: 0..100
  validates :done,    inclusion: [false, true]

  ##############################################################################
  # Callback
  before_validation(on: :create) do
    self.done ||= false

    # Return true to avoid breaking the callback chain
    true
  end

  ##############################################################################
  # ACL
  attr_accessible
  attr_accessible :note, :done, as: :user

  ##############################################################################
  # Scopes
  def self.not_done
    where(done: false)
  end
end
