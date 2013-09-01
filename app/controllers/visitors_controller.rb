class VisitorsController < ApplicationController
	
	def secure_params
  		params.require(:visitor).permit(:business, :contactname, :email, :phone)
  	end

  def new
  	@visitor = Visitor.new
  end

  def create
  	@visitor = Visitor.new(secure_params)

    respond_to do |format|
      if @visitor.save
        Inquiry.inquiry_received(@visitor).deliver
        Inquiry.inquiry_response(@visitor).deliver
        format.html { redirect_to(@visitor, notice: 'Your inquiry has been sent') }
        format.json { render json: @visitor, status: :created, location: @visitor }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  

end
