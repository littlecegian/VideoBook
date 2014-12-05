class Video < ActiveRecord::Base

  belongs_to :category
  belongs_to :student  
  has_attached_file :video, VIDEO_STORAGE_OPTIONS
  
  validates_attachment_presence :video, :message => 'Video File Required'
  validates_attachment_content_type :video, :content_type => VideoAttachment::VALID_CONTENT_TYPES, :message => 'INVALID CONTENT TYPE'
  validates_attachment_size :video, :less_than => VideoAttachment::MAX_SIZE


  #Get specified number of random videos(noofvideos) for the givrn category
  #If category = "all" then extraparam is nil
  #else if category = "categories" or "studentid" then extraparam will have all categories/student ids
  def self.getrandomvideos(noofvideos,category,extraparam=[])
  	if category == "all"
	    getquery = "select * from videos where id not in (select video_id from video_ratings)"
	    records_array = Video.find_by_sql(getquery)
			return getvideodetails(records_array,noofvideos,category)   
		elsif category == "categories"
			#Construct query to select the unjudged videos from the specified categories
			getquery = "select * from videos where (category_id =  "
			extraparam.each_with_index do |eachcategory,index|
				if(index == 0)
					getquery = getquery + eachcategory.to_s
				else
					getquery = getquery + " or category_id = "+ eachcategory.to_s
				end
				#This condition to make sure we select only unjudged videos
				getquery = getquery + ") and id not in (select video_id from video_ratings)"
			end
	    	records_array = Video.find_by_sql(getquery)
			return getvideodetails(records_array,noofvideos,category,extraparam)			
    elsif category == "students"
        #Construct query to select the unjudged videos uploaded by the specified student ids
      getquery = "select * from videos where (student_id =  "
      extraparam.each_with_index do |eachcategory,index|
        if(index == 0)
          getquery = getquery + eachcategory.to_s
        else
          getquery = getquery + " or student_id = "+ eachcategory.to_s
        end
        #This condition to make sure we select only unjudged videos
        getquery = getquery + ") and id not in (select video_id from video_ratings)"
      end
        records_array = Video.find_by_sql(getquery)
      return getvideodetails(records_array,noofvideos,category,extraparam)
    end       
  end

  #Select randomly the specified number of videos for display
  def self.getvideodetails(records_array,noofvideos,category,extraparam=[])
  		result_array = Array.new
  		videoinfo = Array.new    		
        
        #If number of unjudged videos greater than required number, then randomly choose 
        #only the required number of unjudged videos
    	if records_array.length > noofvideos
    		noofvideos.times do    			
	    		index = getrandomnumber(0,records_array.length-1)	 
	    		onerecorddetails = Array.new   		
          #records_array[index].upload_date = records_array[index].upload_date.chomp('UTC')
	    		onerecorddetails.push(addstudentname(records_array.at(index)))
	    		onerecorddetails.push(addcategoryname(records_array.at(index).category_id))
          #onerecorddetails.push(getvideoduration(records_array.at(index).id))
	    		videoinfo.push(onerecorddetails)
	    		#records_array.at(index)[:studentname]= addstudentname(records_array,index)
	    		result_array.push(records_array.at(index))
	    		records_array.delete_at(index)
    		end
    		#byebug
    	#If number of unjudged videos lesser than required number, then choose all the 
    	#existing unjudged videos and for remaining choose from judged videos	
    	elsif records_array.length < noofvideos
    		records_array.each do |record|
    			result_array.push(record)
    			onerecorddetails = Array.new   		
	    		onerecorddetails.push(addstudentname(record))
	    		onerecorddetails.push(addcategoryname(record.category_id))
          #onerecorddetails.push(getvideoduration(record.id))
	    		videoinfo.push(onerecorddetails)
    		end
    		tmp_array = getjudgedvideos(category,noofvideos,records_array.length,extraparam)
    		tmp_array.each do |tmp_record|
    			result_array.push(tmp_record)
    			onerecorddetails = Array.new   		
	    		onerecorddetails.push(addstudentname(tmp_record))
	    		onerecorddetails.push(addcategoryname(tmp_record.category_id))
          #onerecorddetails.push(getvideoduration(tmp_record.id))
	    		videoinfo.push(onerecorddetails)
    		end    	
    	#If number of unjudged videos equal to required number,	then just return that set alone
    	else
    		records_array.each do |record|
    			result_array.push(record)
    			onerecorddetails = Array.new   		
	    		onerecorddetails.push(addstudentname(record))
	    		onerecorddetails.push(addcategoryname(record.category_id))
          #onerecorddetails.push(getvideoduration(record.id))
	    		videoinfo.push(onerecorddetails)
    		end
    	end
    	return result_array,videoinfo
  end

  #This is used when number of unjudged videos less than required videos to display.
  #So for the remaining videos we display already judged videos
  def self.getjudgedvideos(category,noofvideos,existinglength,extraparam = [])
  		if category == "all"
  			return Video.order("RAND()").first(noofvideos-existinglength)
  		elsif category == "categories"
  			getquery = "select * from videos where category_id =  "
			  extraparam.each_with_index do |eachcategory,index|
				  if(index == 0)
				  	getquery = getquery + eachcategory.to_s
				  else
					  getquery = getquery + " or category_id = "+ eachcategory.to_s
				  end
			  end
      elsif category == "students"
        getquery = "select * from videos where student_id =  "
        extraparam.each_with_index do |eachcategory,index|
          if(index == 0)
            getquery = getquery + eachcategory.to_s
          else
            getquery = getquery + " or student_id = "+ eachcategory.to_s
          end
        end                
      if(Video.find_by_sql(getquery).empty?)
         return Video.find_by_sql(getquery)
      else
			   return Video.find_by_sql(getquery).order("RAND()").first(noofvideos-existinglength)
      end
		end		
  			  		
  end

  def self.addstudentname(record)
  		studentname = Student.getstudentname(record.student_id)
	    return studentname.join(" ")
  end

  def self.addcategoryname(categoryid)
  		result = Category.getcategoryname(categoryid)
  		return result.join("")
  end


 # def self.getvideoduration(videoid)
  #    result = Video.where(id: videoid).pluck(:length)
   #   return result.join("")      
  #end


  def self.getrandomnumber(min,max)
  		Random.new.rand(min..max) 
  end
end
