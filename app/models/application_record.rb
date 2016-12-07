class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  acts_as_votable # FIXME: ONLY FOR Micropost!
end
