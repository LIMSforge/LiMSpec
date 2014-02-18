class ProjectsController < InheritedResources::Base
  load_and_authorize_resource

def create
  respond_to do |format|
    if @project.save
      format.html { redirect_to @project, notice: 'Response was successfully created.' }

    else
      format.html { render action: "new" }

    end
  end
end

def new

  @project = current_user.projects.new

  respond_to do |format|
        format.html # new.html.erb

  end
end

def index
  @projects = current_user.projects
  respond_to do |format|
      format.js
      format.html # index.html.erb

  end
end

def destroy
  Project.find(params[:id]).destroy
  redirect_to projects_path
end

def update

end

end
