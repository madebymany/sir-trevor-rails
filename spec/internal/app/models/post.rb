class Post < ActiveRecord::Base
  include SirTrevorRails::HasSirTrevorContent
  sir_trevor_content :body
end
