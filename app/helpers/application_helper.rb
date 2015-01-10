module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Tombstone"      
    end
  end
end
