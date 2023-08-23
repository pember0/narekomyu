module PostsHelper
  def action_and_action?
    controller_name == 'posts' && action_name == 'index' ||
    controller_name == 'posts' && action_name == 'tag_search' ||
    controller_name == 'searches' && action_name == 'index'
  end
end
