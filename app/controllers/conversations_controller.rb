class ConversationsController < ApplicationController
  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conversations }
    end
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/new
  # GET /conversations/new.json
  def new
    @conversation = Conversation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conversation }
    end
  end

  # GET /conversations/1/edit
  def edit
    @conversation = Conversation.find(params[:id])
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @user = User.find_by_cookie(params["cookie"])
    unless @conversation = Conversation.where(:user_id => @user.id, :second_user_id => params["second_user_id"]).first || @conversation = Conversation.where(:user_id => params["second_user_id"], :second_user_id => @user.id).first
      @conversation = Conversation.create!(:user_id => @user.id, :second_user_id => params["second_user_id"])
    end
    render json: @conversation.id
  end

  def new_message
    @conversation = Conversation.find(params["conversation_id"])
    @user = User.find_by_cookie(params["cookie"])
    #@user.conversations
    if @user.id == @conversation.user_id
      @recipient = User.find(@conversation.second_user_id)
    elsif @user.id == @conversation.second_user_id
      @recipient = User.find(@conversation.user_id)
    end

    @message = Message.create(:content => params["content"], :conversation_id => @conversation.id, :sender_id => @user.id, :recipient_id => @recipient.id)
    #render json: @message
    respond_to do |format|
      format.js
    end
  end

  # PUT /conversations/1
  # PUT /conversations/1.json
  def update
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      if @conversation.update_attributes(params[:conversation])
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :no_content }
    end
  end
end
