
module ApplicationHelper
  def set_index(resource)
    @index += 1
    if params[:page]
      resource.class.per_page * (params[:page].to_i - 1) + @index
    else
      @index
    end
  end
end