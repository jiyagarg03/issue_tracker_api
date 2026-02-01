class IssuesController < ApplicationController
  before_action :authorize_request

  def create
    issue = @current_user.issues.new(issue_params)

    if issue.save
      render json: issue, status: :created
    else
      render json: { errors: issue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    issues = Issue.all

    issues = issues.where(status: params[:status]) if params[:status]
    issues = issues.where(priority: params[:priority]) if params[:priority]

    render json: issues
  end

  private

  def issue_params
    params.permit(:title, :description, :status, :priority)
  end
end
