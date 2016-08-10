class AutoraiseticketsController < ApplicationController
  unloadable
  
  before_filter :find_project, :only => :index

  def index
    @project = Project.find(params[:project_id])
  end

  def find_project
    # @project variable must be set before calling the authorize filter
    params[:project_id].nil?? params[:project_id]=1 : params[:project_id]
    @project = Project.find(params[:project_id])
  end  
end
