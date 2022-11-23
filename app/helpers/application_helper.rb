module ApplicationHelper
  def get_username(user_id)
    user_id == current_user.id ? "You" : User.find(user_id).user_name ;
  end

  def alert_class(cls)
    case cls
    when 'created.'
      'alert-success'
    when 'updated.'
      'alert-primary'
    when 'destroyed.'
      'alert-danger'
    else
      'alert-success'
    end
  end
end
