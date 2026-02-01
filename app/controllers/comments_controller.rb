class CommentsController < ApplicationController
  before_action :authorize_request

  def create
    issue = Issue.find(params[:issue_id])
    comment = issue.comments.new(
      content: params[:content],
      user: @current_user
    )

    if comment.save
      render json: comment, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end

