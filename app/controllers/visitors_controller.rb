class VisitorsController < ApplicationController
	
	def secure_params
  		params.require(:visitor).permit(:business, :contactname, :email, :phone)
  	end

  def new
  	@visitor = Visitor.new
  end

  def create
  	@visitor = Visitor.new(secure_params)
  	if @visitor.valid?
      logger.info {"Starting email first"}
      Inquiry.inquiry_received(@visitor).deliver
      logger.info {"Starting email second"}
      Inquiry.inquiry_response(@visitor).deliver
  		flash[:notice] = "Thanks #{@visitor.contactname}, your inquiry is being sent."
  		render :new
  	else
  		render :new
  	end

  	
  end

end
