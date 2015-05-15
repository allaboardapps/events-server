class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :omniauthable, :timeoutable
  devise :database_authenticatable, :recoverable, :rememberable, :registerable,
         :trackable, :validatable, :async

  default_scope { order("LOWER(last_name) ASC, LOWER(first_name) ASC") }
  scope :with_one_of_roles, ->(*roles) { where.overlap(roles: roles) }
  scope :admins, -> { where("'#{Roles::ADMIN}' = ANY (roles)").order(last_name: :asc) }
  scope :active, -> { where(archived: false, test: false) }
  scope :archived, -> { where(archived: true) }
  scope :test, -> { where(test: true) }
  scope :autocomplete, -> (user_query) { active.where("first_name ilike ? or last_name ilike ?", "#{user_query}%", "#{user_query}%").order(last_name: :asc, first_name: :asc) }

  after_create :set_default_role

  def generate_token!
    self.token = SecureRandom.hex
    save!
  end

  def full_name
    "#{first_name} #{last_name}".gsub(/\b('?[a-z])/) { $1.capitalize }.strip
  end

  def first_name_abbreviated(last_name_length = 7)
    first_name_abbrev = first_name.gsub(/\b('?[a-z])/) { $1.capitalize }.strip.slice(0, 1)
    last_name_abbrev = last_name.gsub(/\b('?[a-z])/) { $1.capitalize }.strip.slice(0, last_name_length)
    "#{first_name_abbrev}. #{last_name_abbrev}"
  end

  def last_name_abbreviated(first_name_length = 7)
    first_name_abbrev = first_name.gsub(/\b('?[a-z])/) { $1.capitalize }.strip.slice(0, first_name_length)
    last_name_abbrev = last_name.gsub(/\b('?[a-z])/) { $1.capitalize }.strip.slice(0, 1)
    "#{first_name_abbrev} #{last_name_abbrev}."
  end

  def active_admin_access?
    roles.any? { |role| Roles.system_roles.include?(role) }
  end

  def active_for_authentication?
    super && !self.archived?
  end

  def user_role?
    roles.any? { |role| Roles.user_roles.include?(role) }
  end

  def is?(role)
    roles.include? role
  end

  def is_not?(role)
    !roles.include? role
  end

  def roles_contain_one_of?(allowed_roles)
    roles.any? do |role|
      allowed_roles.include? role
    end
  end

  def set_default_role
    update_attribute :roles, ["user"] if roles.empty?
  end

  def admin?
    is? Roles::ADMIN
  end

  def user?
    is? Roles::USER
  end

  def client?
    is? Roles::USER
  end

  def archived?
    archived
  end

  def active_admin_access?
    roles.any? { |role| Roles.active_admin_roles.include?(role) }
  end

  def archive
    update_attribute(:archived, true)
  end

  def unarchive
    update_attribute(:archived, false)
  end
end
