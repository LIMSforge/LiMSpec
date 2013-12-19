
class UsersController < InheritedResources::Base
  load_and_authorize_resource

  skip_before_filter :require_auth, :only=>[:new, :create]  #will need to filter in the view

  def index

  end
  # GET /users/new
  # GET /users/new.json
  def new
    @user = env['omniauth.identity'] ||= User.new

    #if signed_in?
      #@user = User.new
    #else
      #auth = session['auth']
      #@user = User.create_with_omniauth(auth)
    #end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if @user.save
      appSetting = AppSetting.new()
      appSetting.user_id = @user.id
      appSetting.save()
    end
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
