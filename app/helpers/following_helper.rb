module FollowingHelper
  def follow_link_to(user)
    form_with url: following_index_path, method: :post do |form|
      concat form.hidden_field(:username, value: user.username)
      concat form.submit("Follow user", class: "btn btn-primary btn-lg m-3")
    end
  end
end
