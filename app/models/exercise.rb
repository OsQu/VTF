class Exercise < ActiveRecord::Base
  attr_accessible :description, :name, :parameterized_name, :sources

  belongs_to :category
  has_many :sandboxes
  has_many :source_codes

  validates :name, :presence => true
  validates :parameterized_name, :format => { :with => /\A[a-z]+\z/, :message => "Only lowcase letters are allowed"}

  def compile_source_codes
    sources.split(/,\s+/).each do |file|
      scanned_file = CodeRay.scan_file(
        Rails.root.join("exercises", parameterized_name, "public_html", "app", file)
      )

      source_codes << SourceCode.new(name: file, body: scanned_file.html)
    end
  end
end
