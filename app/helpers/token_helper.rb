module TokenHelper
  def set_token(token)
    $global_token = token
  end

  def get_token
    $global_token
  end

  def delete_token
    $global_token = nil
  end
end