class Inquiry < ActionMailer::Base
  default from: "Course Companion"

  def inquiry_received(inquiry)
  	mail(:to => "andrewkemp70@gmail.com", :subject => "Demo Inquiry From CourseCompanion")
  end

  def inquiry_response(inquiry)
  	@inquiry = inquiry
  	mail(:to => inquiry.email, :subject => "Thank you for your inquriy for a Course Companion Demo")
  end
end
