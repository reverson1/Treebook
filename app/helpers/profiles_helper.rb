module ProfilesHelper
	def self.gravatar_url(email)
  	begin
	    email_strip = email.strip
	    downcase_email = email_strip.downcase    
	    hash = Digest::MD5.hexdigest(downcase_email)
	    
	    "http://gravatar.com/avatar/#{hash}"
	  rescue
	  	"http://gravatar.com/avatar/"
	  end
  end

  def self.getfullname(first_name, last_name)
  	begin
    	first_name + ' ' + last_name
    rescue
    	''
    end
  end
end
