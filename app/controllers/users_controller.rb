class UsersController < ApplicationController
  include EventPublisher

  before_action :find_user, only:  %i[show destroy update edit]

  def index
    @pagy, @users = pagy(User.all)
    @user = User.new

    @pagy_logs, @audit_logs = pagy(AuditLog.all.order(created_at: :desc).limit(5))

    # Rails.logger.debug "=== DEBUG ==="
    # Rails.logger.debug "Request format: #{request.format}"
    # Rails.logger.debug "Params: #{params.inspect}"
    # Rails.logger.debug "Turbo Frame?: #{request.headers['Turbo-Frame']}"

    respond_to do |format|
      format.html
    end
  end

  def show
  end

  def new
    @user = User.new
    @minimum_password_length = 6  # or get from model validation

    # after makeing a turbo_stream request from the link we need to add format
  end

  def create
    @user = User.new(user_params)
    @record = @user
    if @user.save
      flash.now[:success] = "<strong>#{@user.name}</strong> has been created!".html_safe
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to users_url }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity  }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash.now[:success] = "<strong>#{@user.name}</strong> has been updated!".html_safe
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @user }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!

    respond_to do |format|
      flash.now[:success] = "User has been deleted!".html_safe
      format.html { redirect_to users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
  def user_params
    params.expect(user: [ :name, :id, :username, :password, :password_confirmation ])
  end

  def find_user
    @user = User.find(params[:id])
    @record = @user
  end
end
