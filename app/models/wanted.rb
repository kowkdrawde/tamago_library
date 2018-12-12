class Wanted < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  def wanted_on
    created_at.strftime 'on %d %b %Y'
  end


end
