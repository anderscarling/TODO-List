class User < Struct.new(:provider, :uid)

  ##############################################################################
  # Login Handling #############################################################

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

    new(auth_hash['provider'], auth_hash['uid'])
  end

  ##############################################################################
  # Session Handling, called from UserAuth (included in ApplicationController) #

  # Create User instance from session hash – will return nil if hash
  # does not contain a user_id key.
  def self.create_from_session(session)
    new(*session['user_id']) if session['user_id']
  end

  def store_in_session(session)
    session['user_id'] = [self.provider, self.uid]
  end

  ##############################################################################
  # Object inspection
  def to_s
    "#{self.uid} on #{self.provider}"
  end

  ##############################################################################
  # Object id
  def id
    "%s@%s" % [self.uid, self.provider]
  end

  def ==(other)
    other.is_a?(User) and self.id == other.id
  end


  ##############################################################################
  # Relations to Todos
  def todos
    Todo.where(user_id: self.id)
  end

end
