class Label < ApplicationRecord

  has_many :labelings
  has_many :topics,   through: :labelings, source: :labelable, source_type: :Topic
  has_many :posts,    through: :labelings, source: :labelable, source_type: :Post

  default_scope { order('name ASC') }

  def self.update_labels(string_of_labels)
    return Label.none if string_of_labels.blank?
    string_of_labels.split(',').map { |label| Label.find_or_create_by(name: label.strip) }
  end

end