class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  has_many :collaborators
  has_many :wikis
  has_many :collaborations, through: :collaborators, source: :wiki_id
  
  after_initialize :set_role
  
  def set_role
    self.role ||= 'standard'
  end
  
  def admin?
    role == 'admin'
  end
  
  def premium?
    role == 'premium'
  end
  
  def standard?
    role == 'standard'
  end
  
  def make_wikis_public
    wikis.each do |wiki|
      if wiki.private == true
        wiki.update_attributes(private: false)
      end
    end
  end
  
end
