class Role < ApplicationRecord
  belongs_to :role_type
  has_many :users, :dependent => :restrict_with_error

  validates_uniqueness_of :role_type_id
  validates_presence_of :role_type_id
  # before_save do
  #   self.name = role_type
  # end
  # validates_presence_of :name
  # validates_uniqueness_of :name

  class PermissionsAttributeCoder
    def self.load(str)
      str.to_s.scan(/:([a-z0-9_]+)/).flatten.map(&:to_sym)
    end

    def self.dump(value)
      YAML.dump(value)
    end
  end

  def role_type
    if role_type_id
      super
    else
      RoleType.default
    end
  end


  serialize :permissions, ::Role::PermissionsAttributeCoder

  scope :active, lambda { where(:state => true) }

  def to_s
    name
  end

  before_save do
    self.name = role_type.to_s
  end

  def self.default
    Role.where(role_type_id: RoleType.default.try(:id) ).first
  end

  def setable_permissions
    setable_permissions = RedCarpet::AccessControl.permissions - RedCarpet::AccessControl.public_permissions
    setable_permissions
  end

  def permissions=(perms)
    perms = perms.collect {|p| p.to_sym unless p.blank? }.compact.uniq if perms
    write_attribute(:permissions, perms)
  end

end
