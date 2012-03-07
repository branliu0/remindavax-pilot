require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  username           :string(255)
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean(1)      default(FALSE)
#  phc_id             :integer(4)
#  created_at         :datetime
#  updated_at         :datetime
#

