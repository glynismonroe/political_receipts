class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  

  def index
    @receipts = Receipt.all
  end

  def show
  end
 # GET /receipts/new
  def new
    @receipt = Receipt.new
    @receipt = current_user.receipt.build
  end
 # GET /receipts/1/edit
  def edit
  end

  def create
    @receipt = current_user.receipts.build(receipt_params)
      if @receipt.save
        redirect_to @receipt, notice: 'Receipt was successfully created'.
          else
            render action: 'new'
      end
  end
  
  
    respond_to do |format|
      if @receipt.save
        format.html { redirect_to @receipt, notice: 'Receipt was successfully created.' }
        format.json { render :show, status: :created, location: @receipt }
      else
        format.html { render :new }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  

  def update
    @receipt = current_user.receipts.build(receipt_params)
      # if @receipt.save
        redirect_to @receipt, notice: 'Receipt was successfully created'.
      else
    respond_to do |format|
      if @receipt.update(receipt_params)
        # format.html { redirect_to @receipt, notice: 'Receipt was successfully updated.' }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
  end


  def destroy
    @receipt.destroy
    respond_to do |format|
      format.html { redirect_to receipts_url, notice: 'Receipt was successfully destroyed.' }
      format.json { head :no_content }
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receipt_params
      params.require(:receipt).permit(:description)
    end
  end
   
   def correct_user
      @receipts = current user.receipts.find_by(id: params[:id])
      redirect_to receipts_path, notice: "Not authorized to edit this receipt" if @receipt.nil?
   end
  end
end