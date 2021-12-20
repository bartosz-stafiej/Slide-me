# frozen_string_literal: true

require 'constants/sql/literals'

class Role < ApplicationRecord
  SQL_TRUE = Constants::SQL::Literals::TRUE

  belongs_to :user,
             inverse_of: :roles

  belongs_to :created_by,
             class_name: :User,
             inverse_of: :created_roles,
             optional: true

  def self.checklist(user)
    body = user.roles.pluck(:name, SQL_TRUE).to_h
    Roles::Checklist.new(body)
  end
end
