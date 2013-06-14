module FeedsHelper

  def hot?
    last_modified.to_i > last_visited.to_i
  end

end
