class LeafsController < ApplicationController
  before_action :set_leaf, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  
  # GET /leafs
  # GET /leafs.json
  def index
    @leafs = Leaf.where("original_id = '' or original_id is null").order("id DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leafs }
    end
  end

  # GET /leafs/1
  # GET /leafs/1.json
  def show   
    @leafs = Array.new
    @leafs.concat(Leaf.where("id = #{params[:id]}"))
    @leafs.concat(Leaf.where("original_id = #{params[:id]}").order("updated_at DESC"))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @leaf}
    end
  end

  # GET /leafs/new
  def new
    @leaf = Leaf.new
  end

  # GET /leafs/1/edit
  def edit
  end
  
  # GET /leafs/1/edit
  def reply
  #get original leaf
  @original_leaf = Leaf.find(params[:id])

  #create reply leaf
  @leaf = Leaf.new
  @leaf.content = params[:content]
  @leaf.user_id = current_user[:id]
  @leaf.original_id  = params[:id]
  end

  # POST /leafs
  # POST /leafs.json
  def post_reply
    #get original message
    @original_leaf = Leaf.find(params[:id])

    #get content of original message   
    @original_content = @original_leaf[:content]

    #create reply leaf and fill with params
    @leaf = Leaf.new
    @leaf.content = params[:leaf][:content] 
    @leaf.user_id = current_user[:id]
    @leaf.original_id = params[:id]
    
    #try to save the new leaf and update original_leaf
    respond_to do |format|
      if @leaf.save
        @original_leaf[:updated_at] = @leaf[:updated_at]
        @original_leaf.save
        format.html { redirect_to @original_leaf, notice: 'Reply leaf was successfully planted.' }
        format.json { render action: 'show', leaf: :created, location: @original_leaf }
      else
        format.html { render action: 'reply', :leaf_params => @leaf }
        format.json { render json: @leaf.errors, leaf: :unprocessable_entity }
      end
    end
  end



  # POST /leafs
  # POST /leafs.json
  def create
    @leaf = Leaf.new(leaf_params)
    @leaf.content = params[:leaf][:content]
    @leaf.user_id = params[:leaf][:user_id]
    @leaf.original_id  = params[:leaf][:original_id]
    @leaf.created_at = params[:leaf][:created_at]
    @leaf.updated_at = params[:leaf][:updated_at]
  end

  # PATCH/PUT /leafs/1
  # PATCH/PUT /leafs/1.json
  def update
    respond_to do |format|
      if @leaf.update(leaf_params)
        format.html { redirect_to @leaf, notice: 'Leaf was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @leaf.errors, leaf: :unprocessable_entity }
      end
    end
  end

  # DELETE /leafs/1
  # DELETE /leafs/1.json
  def destroy
    @leaf.destroy
    respond_to do |format|
      format.html { redirect_to leafs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leaf
      begin
        @leaf = Leaf.find(params[:id])
      rescue ActiveRecord::RecordNotFound  
       redirect_to "new_user_session_path"
      end
    end

    # Never  trust parameters from the scary internet, only allow the white list through.
    def leaf_params
      params.require(:leaf).permit( :content, :user_id, :original_id)
    end
end
