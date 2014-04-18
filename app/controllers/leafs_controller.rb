class LeafsController < ApplicationController
  before_action :set_leaf, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]
  
  # GET /leafs
  # GET /leafs.json
  def index
    @leafs = Leaf.all(:order => 'created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leafs }
    end
  end

  # GET /leafs/1
  # GET /leafs/1.json
  def show
    @leaf  = Leaf.find(params[:id])

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
  
  # POST /leafs
  # POST /leafs.json
  def reply
    @original_leaf = Leaf.find(params[:id])
    @leaf = Leaf.new
  end

  # POST /leafs
  # POST /leafs.json
  def create
    @leaf = Leaf.new(leaf_params)

    respond_to do |format|
      if @leaf.save
        format.html { redirect_to @leaf, notice: 'Leaf was successfully created.' }
        format.json { render action: 'show', leaf: :created, location: @leaf }
      else
        format.html { render action: 'new' }
        format.json { render json: @leaf.errors, leaf: :unprocessable_entity }
      end
    end
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
      params.require(:leaf).permit( :content, :user_id)
    end
end
