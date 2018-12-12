module CommonMethod

  def randomise_id(model)
    self.id = SecureRandom.random_number(100000)
    model.where(id: self.id).exists? ? randomise_id : self.id
  end

end