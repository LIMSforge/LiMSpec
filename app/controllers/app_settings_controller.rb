
class AppSettingsController < ApplicationController

  # GET /app_settings/1
  # GET /app_settings/1.json
  def show
    @app_setting = AppSetting.find_by_user_id(current_user.id)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @app_setting }
    end
  end

  # GET /app_settings/1/edit
  def edit
    @app_setting = AppSetting.find_by_user_id(session[:user_id])
    if @app_setting.nil?
      @app_setting = AppSetting.new()
      @app_setting.user_id = session[:user_id]
      @app_setting.save()
    end
  end

  # PUT /app_settings/1
  # PUT /app_settings/1.json
  def update
    @app_setting = AppSetting.find(params[:id])

    respond_to do |format|
      if @app_setting.update_attributes(params[:app_setting])
        session['showIndustry'] = @app_setting.showIndustry
        format.html { redirect_to edit_user_path(current_user), notice: 'App setting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @app_setting.errors, status: :unprocessable_entity }
      end
    end
  end


end
