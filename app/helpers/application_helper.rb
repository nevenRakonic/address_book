module ApplicationHelper

  def bootstrap_class(flash)
    class_map = {
     "success" => "alert-success",
     "error" => "alert-danger",
     "alert" => "alert-warning",
     "notice" => "alert-info",
    }
    class_map[flash]
  end
end
