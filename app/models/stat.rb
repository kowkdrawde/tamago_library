class Stat < ActiveRecord::Base

  def self.get_freq_loc
    find_by(name: "freq_loc").content.keys    
  end

  def self.get_avail_book_count
    find_by(name: "avail_book_count").content.values.first.to_i
  end

end
