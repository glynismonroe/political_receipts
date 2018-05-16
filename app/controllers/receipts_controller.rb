class ReceiptsController < ApplicationController
    before_action :set_receipt, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    before_action :correct_user, only: [:edit, :update, :destroy]
    
    respond_to :html

  def index
    @receipts = Receipt.all
  end

  def show
  end

  def new
    @receipt = Receipt.new
  end

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

  def update
      if @receipt.update(receipt_params)
        redirect_to @receipt, notice: 'Receipt was successfully updated'.
       else
        render action: 'edit'
      end
  end
   
 
  def destroy
    @receipt.destroy
    redirect_to receipts_url, notice: 'Receipt was successfully destroyed.' 
  end
   
   
  private
    # Use callbacks to share common setup or constraints between actions.
 
  def set_receipt
    @receipt = Receipt.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def receipt_params
    params.require(:receipt).permit(:description, :image)
  end
  
  def correct_user
      @receipts = current_user.receipts.find_by(id: params[:id])
      redirect_to receipts_path, notice: "Not authorized to edit this receipt" if @receipt.nil?
  end
end