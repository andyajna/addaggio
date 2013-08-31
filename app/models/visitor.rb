class Visitor < ActiveRecord::Base
	has_no_table
	column :business, :string
	column :contactname, :string
	column :email, :string
	column :phone, :string
	validates_presence_of :business, :contactname, :email

	IMAGE_LABELS = ['Any Smartphone', 'Your Own Content', 'Adult Learning']

	def update_spreadsheet
		connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"])
		ss = connection.spreadsheet_by_title('addaggio-inquiries')
		if ss.nil?
			ss = connection.create_spreadsheet('addaggio-inquiries')
		end
		ws = ss.worksheets[0]
		last_row = 1 + ws.num_rows
		ws[last_row, 1] = Time.now 
		ws[last_row, 2] = self.business 
		ws[last_row, 3] = self.contactname
		ws[last_row, 4] = self.email
		ws[last_row, 5] = self.phone 
		ws.save
end

end