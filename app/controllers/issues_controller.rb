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
  page = params[:page].to_i > 0 ? params[:page].to_i : 1
  per_page = 10
  offset = (page - 1) * per_page

  issues = Issue.all
  issues = issues.by_status(params[:status]) if params[:status]
  issues = issues.by_priority(params[:priority]) if params[:priority]

  render json: {
    page: page,
    count: issues.count,
    issues: issues.limit(per_page).offset(offset)
  }
end

def update
  issue = Issue.find(params[:id])

  unless issue.user == @current_user || @current_user.admin?
    return render json: { error: "Forbidden" }, status: :forbidden
  end

  if issue.update(status: params[:status])
    render json: issue
  else
    render json: { errors: issue.errors.full_messages }, status: :unprocessable_entity
  end
end


def analytics
  unless @current_user.admin?
    return render json: { error: "Forbidden" }, status: :forbidden
  end

  render json: {
    total: Issue.count,
    open: Issue.open.count,
    in_progress: Issue.in_progress.count,
    resolved: Issue.resolved.count
  }
end


  private

  def issue_params
    params.permit(:title, :description, :status, :priority)
  end
end
