class Article < ApplicationRecord
  enum category: { superhero: 0, local: 1, health: 2, money: 3 }

  belongs_to :user
end
