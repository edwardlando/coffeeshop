class UsersController < ApplicationController

  def jsupdate
    @user = User.find_by_cookie(params["cookie"])
    if params["name"]
      @user.name = params["name"]
      @user.email = params["email"]
      @user.desc = params["desc"]
      @user.save!
    elsif params["currenturl"]
      @user.current_url = params["currenturl"].split('?')[0]
      @user.save!
    end
    render json: @user.id
  end

  def jsshow
    @user = User.find_by_cookie(params["cookie"])
    @conversations = Conversation.find_all_by_user_id(@user.id)
    if @user.name
      render json: { name: @user.name, conversations: @conversations } 
    else
      render json: 'none'
    end
  end

  def jsindex
    @user = User.find_by_cookie(params["cookie"])
    current_url = @user.current_url
    @users = User.find_all_by_current_url(current_url)
    @me = []
    @me << @user
    @users = @users - @me
    render json: @users
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

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

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
