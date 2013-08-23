// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


//$(function() {
	//$("#myads_search input").keyup(function() {
	//	$.get($("#myads_search").attr("action"), $("#myads_search").serialize(), null, "script");
	//	return false;
	//});
//});
$(function() {

	if($('h1#user_management').text() == "Users List")
	{
		$('.tabs .tab-nav > li.active').removeClass('active')	
		$('.tabs .tab-nav > li.user_management').addClass('active')
	}else if($('h1#advertise_management').text() == "Advertisement List"){
		$('.tabs .tab-nav > li.active').removeClass('active')
		$('.tabs .tab-nav > li.advertisement_management').addClass('active')
	}else if($('h1#category_management').text() == "Category List"){
		$('.tabs .tab-nav > li.active').removeClass('active')
		$('.tabs .tab-nav > li.category_management').addClass('active')
	}else if($('h1#characteristics_management').text() == "Characteristics List"){
	$('.tabs .tab-nav > li.active').removeClass('active')
		$('.tabs .tab-nav > li.characteristics_management').addClass('active')
	}



	$("#abuse_ads .pagination a").click(function() {
    	$.get('/abuse_ads_listing_admin',function(data){
        },"script");
    	return false;
  	});
  	
  	$('#my_fav_section').addClass('hide_selectbox');
    $('#my_ads_section').addClass('hide_selectbox');
    $('.tabs .tab-nav > li.profile_management').addClass('active')

  	$('#my_profile').click(function(){
  		$.get('/myprofile',function(data){
        },"script");
    	$('#my_profile_section').removeClass('hide_selectbox');
    	$('#my_fav_section').addClass('hide_selectbox');
    	$('#my_ads_section').addClass('hide_selectbox');
    	
    	$('.tabs .tab-nav > li.active').removeClass('active')
		$('.tabs .tab-nav > li.profile_management').addClass('active')
    	return false;
  	});
  	
  	$('#my_fav').click(function(){
  		$.get('/myfavs',function(data){
        },"script");
    	$('#my_profile_section').addClass('hide_selectbox');
    	$('#my_fav_section').removeClass('hide_selectbox');
    	$('#my_ads_section').addClass('hide_selectbox');
    	$('.tabs .tab-nav > li.active').removeClass('active')
		$('.tabs .tab-nav > li.favourite_management').addClass('active')
    	return false;
  	});
  	$('#my_ads').click(function(){
  		$.get('/myads',function(data){
        },"script");
    	$('#my_profile_section').addClass('hide_selectbox');
    	$('#my_fav_section').addClass('hide_selectbox');
    	$('#my_ads_section').removeClass('hide_selectbox');
    	$('.tabs .tab-nav > li.active').removeClass('active')
		$('.tabs .tab-nav > li.ads_management').addClass('active')
    	return false;
  	});

    $('#flash_message').delay(3000).fadeOut();
    
});


