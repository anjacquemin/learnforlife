module AllThemeSeed
  def self.seed
    history = Theme.new(name: "A venir")
    history.image_src = '<i class="fas fa-atlas"> </i>'
    history.adventure_only = false
    history.save!

    mnemotechnique = Theme.new(name: "A venir #2")
    mnemotechnique.image_src = '<i class="fas fa-atlas"> </i>'
    mnemotechnique.adventure_only = false
    mnemotechnique.save!

    sports = Theme.new(name: "A venir #3")
    sports.image_src = '<i class="fas fa-atlas"> </i>'
    sports.adventure_only = false
    sports.save!
  end
end
