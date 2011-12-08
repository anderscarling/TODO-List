class User < ActiveRecord::Base
  ##############################################################################
  # Associations
  has_many :todos

  ##############################################################################
  # Validations
  validates :provider, :uid, presence: true

  ##############################################################################
  # ACL
  attr_accessible :uid, :provider
  attr_readonly   :uid, :provider

  ##############################################################################
  # Login Handling

  # Create User instance from OmniAuth authhash – will raise exception
  # if auth_hash is not an hash with a provider and uid value.
  def self.create_from_auth_hash!(auth_hash)
    # We don't check if auth_hash is nil, instead we make sure there is
    # a hash, and  check if the keys are present 
    auth_hash ||= {}
    provider, uid = auth_hash['provider'], auth_hash['uid']

    unless [provider,uid].all?(&:present?)
      raise(ArgumentError, "Invalid auth hash")
    end

    # We use this instead of find_or_create in order to get an exception
    # if save fails.. Calling #save! on a existing record should be no
    # problem and should cause no extra sql queries since rails knows no
    # attributes are changed.
    find_or_initialize_by_provider_and_uid(provider, uid).tap { |u| u.save! }
  end

  ##############################################################################
  # Session Handling, called from UserAuth (included in ApplicationController)

  # Create User instance from session hash – will return nil if hash
  # does not contain a user_id key.
  def self.find_from_session(session)
    find_by_id(session['user_id'])
  end

  def store_in_session(session)
    session['user_id'] = self.id
  end

  ##############################################################################
  # Object inspection
  def to_s
    "#{self.uid} on #{self.provider}"
  end

end
