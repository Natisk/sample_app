json.(comment, :body, :micropost_id)
json.commenter do
  json.name comment.commenter.name
  json.avatar_img gravatar_for(comment.commenter, 40)
  json.user_url user_path(comment.commenter)
end
json.commented_at "Commented #{time_ago_in_words(comment.created_at)}"

if can?(:destroy, comment)
  json.destroy_link micropost_comment_path(comment.micropost, comment)
end