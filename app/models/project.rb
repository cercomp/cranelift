class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  after_update :update_directory_name

  has_many :repositories, :dependent => :destroy
  has_and_belongs_to_many :users

  scope :name_asc, order('LOWER(name)')

  validates :name,
            :presence => :true,
            :uniqueness => true,
            :length => {:in => 3..32}

  def update_directory_name
    # http://stackoverflow.com/questions/1487548/how-to-get-the-original-value-of-an-attribute-in-rails
    if slug_was != slug
      FileUtils.mv REPOS_PATH.join(slug_was).to_s, REPOS_PATH.join(slug).to_s
    end
  end
end
