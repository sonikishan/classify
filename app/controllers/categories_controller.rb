class CategoriesController < ApplicationController
	helper_method :sort_column, :sort_direction
	before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
	before_filter :authenticate_user!, except: [:category_listing,:category_filtering,:price_search,:sort_column] do 
    redirect_to root_path unless current_user.admin?
  end

	# GET /categories
	# GET /categories.json
	def index
		@categories = Category.paginate(:page => params[:page], :per_page => 5)
		@category_root = Category.roots.search(params[:search]).paginate(:page => params[:page], :per_page => 5)
		respond_to do |format|
			format.html # index.html.erb
			format.js
			# format.json { render json: @categories }
		end
	end

	# GET /categories/1
	# GET /categories/1.json
	def show
		@category = Category.find(params[:id])
		@child_category_ids = @category.child_ids
		@child_category = Category.where("id in (?)",@child_category_ids)

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @category }
		end
	end

	# GET /categories/new
	# GET /categories/new.json
	def new
		@category = Category.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @category }
		end
	end

	# GET /categories/1/edit
	def edit
		@category = Category.find(params[:id])
	end

	# POST /categories
	# POST /categories.json
	def create
		@category = Category.new(params[:category])

		respond_to do |format|
			if @category.save
				format.html { redirect_to @category, notice: 'Category was successfully created.' }
				format.json { render json: @category, status: :created, location: @category }
			else
				format.html { render action: "new" }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /categories/1
	# PUT /categories/1.json
	def update
		@category = Category.find(params[:id])

		respond_to do |format|
			if @category.update_attributes(params[:category])
				format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @category.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /categories/1
	# DELETE /categories/1.json
	def destroy
		@category = Category.find(params[:id])
		@category.destroy

		respond_to do |format|
			format.html { redirect_to categories_url }
			format.json { head :no_content }
		end
	end
	def destroy_category
		@count = 0
		@category_new = Category.new
		@category = Category.find(params[:id])
		@count += @category.advertisements.count
		@child_category_ids = @category.child_ids
		 @child_category = Category.where("id in (?)",@child_category_ids)
		 @child_category.each do |child|
			@count += child.advertisements.count
			@sub_child_ids = child.child_ids
			@sub_child =  Category.where("id in (?)",@sub_child_ids)
				@sub_child.each do |sub_child|
					@count+= sub_child.advertisements.count
				end
		 end
	end

	def destroy_category_ads
		@category = Category.find(params[:id])
		@parent_ad = []
		@sub_child_ad = []
		@child_ad = []
		@parent_ad << @category.advertisements.map{ |ads| ads.destroy }
		@child_category_ids = @category.child_ids
		if !@child_category_ids.blank?
			 @child_category = Category.where("id in (?)",@child_category_ids)
			 @child_category.each do |child|
				@child_ad << child.advertisements.map{ |ads| ads.destroy }
				@sub_child_ids = child.child_ids
				if !@sub_child_ids.blank?
					@sub_child =  Category.where("id in (?)",@sub_child_ids)
					@sub_child.each do |sub_child|
						@sub_child_ad << sub_child.advertisements.map{ |ads| ads.destroy }
						sub_child.destroy
						child.destroy
					end
				else
					child.destroy
				
				end
			end
		else
		
		end
			@category.destroy
		redirect_to categories_path, :notice => "Successfully Deleted."
	end

def move_ads
	@category = Category.find(params[:category][:select_category_id])
	@parent_cat_ads = []
	@child_cat_ad = []
	@sub_child_cat_ad = []
		if !params[:advertisement].blank?
			@parent_cat_ads << @category.advertisements.map{ |i| i.update_attributes(:category_id => params[:advertisement][:category_id])} 
			@child_category_ids = @category.child_ids  
				if !@child_category_ids.blank? 
					@child_category = Category.where("id in (?)",@child_category_ids)
					@child_category.each do |child|
						@child_cat_ad << child.advertisements.map{ |i| i.update_attributes(:category_id => params[:advertisement][:category_id])}
						@sub_child_ids = child.child_ids
						if !@sub_child_ids.blank?
							@sub_child =  Category.where("id in (?)",@sub_child_ids)
							@sub_child.each do |sub_child|
								@sub_child_cat_ad << sub_child.advertisements.map{|i|i.update_attributes(:category_id => params[:advertisement][:category_id])}
								sub_child.destroy
								child.destroy
							end
						else
							child.destroy
						end
					end   
				else
						
				end            
		else
			@parent_cat_ads << @category.advertisements.map{ |i| i.update_attributes(:category_id => params[:category][:id])} 
			@child_category_ids = @category.child_ids  
				if !@child_category_ids.blank? 
					@child_category = Category.where("id in (?)",@child_category_ids)
					@child_category.each do |child|
						@child_cat_ad << child.advertisements.map{ |i| i.update_attributes(:category_id => params[:category][:id])}
						@sub_child_ids = child.child_ids
						if !@sub_child_ids.blank?
							@sub_child =  Category.where("id in (?)",@sub_child_ids)
							@sub_child.each do |sub_child|
								@sub_child_cat_ad << sub_child.advertisements.map{|i|i.update_attributes(:category_id => params[:category][:id])}
									sub_child.destroy
									child.destroy
								end
						else
							child.destroy
						end
					end   
				else

				end            
		end
		@category.destroy
		redirect_to categories_path, :notice => "Successfully Deleted."
end

	def advertisement_list
		@category = Category.find(params[:id])
		@parent_ad = []
		@sub_child_ad = []
		@child_ad = []
		@parent_ad << @category.advertisements
		@parent_ad = @parent_ad.flatten
		@child_category_ids = @category.child_ids
		 @child_category = Category.where("id in (?)",@child_category_ids)
		 @child_category.each do |child|
			@child_ad << child.advertisements
			@child_ad = @child_ad.flatten
			@sub_child_ids = child.child_ids
			@sub_child =  Category.where("id in (?)",@sub_child_ids)
				@sub_child.each do |sub_child|
					@sub_child_ad << sub_child.advertisements
					@sub_child_ad = @sub_child_ad.flatten
				end
		end
	end
	def category_listing
		@category = Category.find(params[:id])
		@child_category_ids = @category.child_ids
		@child_category = Category.where("id in (?)",@child_category_ids)
	    respond_to do |format|
			format.html{}
		end
	end

	def price_search
		@category = Category.find(params[:category_id])
		@advertisement_characterstic = []
		@advertisement = []
		if !params[:default_value].blank? 
			@advertisement_characterstic << AdvertisementCharacteristic.where("value like ? ","%#{params[:default_value][:default_value]}%")
		end	
		if !params[:characteristics_select][:default_value].blank? 
			@advertisement_characterstic << AdvertisementCharacteristic.where("value like ? ","%#{params[:characteristics_select][:default_value]}%")
		end
		if !params[:characteristic].blank? 
			@values =  params[:characteristic][:default_value].split(',').join(' ')
			@values.split(' ').each do |char|
				@advertisement_characterstic << AdvertisementCharacteristic.where("value like ? ","%#{char}%")
			end
		end
		if !params[:minprice].blank? and !params[:maxprice].blank? 
			@advertisement << Advertisement.where("price >= (?) AND price <= (?) AND advertisement_status_id not in (?)",params[:minprice],params[:maxprice],[2]).order(sort_column + " " + sort_direction)
		end	
		@advertisement_characterstic = @advertisement_characterstic.flatten!
		if params[:minprice].blank? and params[:maxprice].blank? 
			@advertisement_characterstic.each do |advertisement_characterstic|
				@advertisement << Advertisement.where("id in (?) AND advertisement_status_id not in (?)",advertisement_characterstic.advertisement_id,[2]).order(sort_column + " " + sort_direction)
			end
		end
		@advertisement = @advertisement.flatten!
		
		
	end
	def category_filtering
		@category = Category.find(params[:id])
		@characteristic = Characteristic.new
		@parent = Category.find(params[:parent_id])
		@root = @parent.root
		@advertisement = Advertisement.order(sort_column + " " + sort_direction)
	end

	def category_status
		@category = Category.find(params[:id])
		@first_generation_ids =  @category.child_ids
		@first_generation = Category.where("id in (?)", @first_generation_ids)
		if @category.active_status == true
		@category.update_attributes(:active_status => false)
		@first_generation.each do |category|
			category.update_attributes(:active_status => false)
			@second_generation_ids =  @category.child_ids
			@second_generation = Category.where("id in (?)", @second_generation_ids)
			@second_generation.each do |sub_category|
				sub_category.update_attributes!(:active_status => false)
			end
		end
	else
		@category.update_attributes(:active_status => true)
		@first_generation.each do |category|
			category.update_attributes(:active_status => true)
			@second_generation_ids =  @category.child_ids
			@second_generation = Category.where("id in (?)", @second_generation_ids)
			@second_generation.each do |sub_category|
				sub_category.update_attributes!(:active_status => true)
			end
		end
	end 
	end
	
	def sub_category_status
		@first_generation = Category.find(params[:id])
		@second_generation_ids =  @first_generation.child_ids
		 @second_generation = Category.where("id in (?)", @second_generation_ids)
		if @first_generation.active_status == true
		@first_generation.update_attributes(:active_status => false)
		@second_generation.each do |category|
			category.update_attributes(:active_status => false)
		end
	else
		@first_generation.update_attributes(:active_status => true)
		@second_generation.each do |category|
			category.update_attributes(:active_status => true)
		end
	end 
	end
	def sub_category_child_status
		@sub_category = Category.find(params[:id])
		if @sub_category.active_status == true
		@sub_category.update_attributes(:active_status => false)
	else
		@sub_category.update_attributes(:active_status => true)
	end 
	end
	private

	def sort_column
		 Advertisement.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
	end

	def sort_direction
	 %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
	end
end
