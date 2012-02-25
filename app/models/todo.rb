require 'csv'

class Todo < ActiveRecord::Base
  ##############################################################################
  # Associations
  belongs_to :user

  ##############################################################################
  # Validates
  validates :user_id, presence: true
  validates :note,    presence: true, length: 0..100
  validates :done,    inclusion: [false, true]

  ##############################################################################
  # Serialization
  class TagsSerializer
    def self.load(text)
      return unless text
      CSV.parse(text)
    end

    def self.dump(text)
      return unless text
      text.to_csv
    end
  end
  serialize :tags, TagsSerializer

  ##############################################################################
  # Callback
  before_validation(on: :create) do
    self.done ||= false

    # Return true to avoid breaking the callback chain
    true
  end


  ##############################################################################
  # Attributes
  def note_with_meta; nil; end
  def note_with_meta=(str)
    if str.is_a?(String)
      self.note, self.tags, self.times = parse_note(str)
      str
    else
      self.note = str
    end
  end

  def tags=(ary)
    super(ary.uniq)
  end

  def times=(ary)
    self.due_at       = Chronic.parse(ary.pop)
    self.available_at = Chronic.parse(ary.pop).try(:to_date)
    ary.each { |str| self.note += " @ #{str}" }
  end

  def parse_note(str)
    parts = str.scan(/(?:\A|#|@)[^@#]*/).map(&:strip)

    note  = parts.first { |str| str =~ /^[^@#]/ }
    tags  = parts.map { |str| str[/(?<=#).*/].try(:strip) }.compact
    times = parts.map { |str| str[/(?<=@).*/].try(:strip) }.compact

    return note, tags, times
  end
  private :parse_note

  ##############################################################################
  # ACL
  attr_accessible
  attr_accessible :note_with_meta, :done, as: :user

  ##############################################################################
  # Scopes
  def self.not_done
    where(done: false)
  end
end
