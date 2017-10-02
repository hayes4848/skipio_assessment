module ApplicationHelper

  def pretty_address(street, city, state, zip)
    if street && street.length > 2 
      "<div>#{street}</div> <div>#{city}, #{state} #{zip}</div>".html_safe
    else
      "No Address Available"
    end  
  end  

end
