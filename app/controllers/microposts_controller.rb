class MicropostsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user,   only: :destroy
  
  VALID_URL_REGEX =  /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  def create 
    check_if_url_is_valid
    @micropost = Micropost.find_or_initialize_by_url(params[:micropost])
    if(start_parsing_site == nil)
      return
    end
    increase_number_of_shares_for_micropost
    create_and_save_micropost
  end

  def create_and_save_micropost
    if @micropost.save
      Userpost.find_or_create_by_user_id_and_micropost_id(user_id: current_user.id, micropost_id: @micropost.id)
      create_the_list_of_tags_for_artice_if_none_in_tags
      set_general_category_for_article  
      save_tags_and_categories_for_article 
      redirect_to root_url
      flash[:success] = "Post created"
    else
      flash[:warning] = "Something went wrong"
      redirect_to root_url
    end
  end

  def start_parsing_site
    @newTag = []
    if(!parse(@micropost.url))
      # redirect_to root_url
      flash[:error] = "Invalid site"
      return nil
    else
      return 1
    end
  end
  
  def increase_number_of_shares_for_micropost
    if(Userpost.where(user_id: current_user.id, micropost_id: @micropost.id) == [])
      @micropost.count += 1
    end
  end
  
  def create_the_list_of_tags_for_artice_if_none_in_tags
    if(!@newTag.any?)
        @micropost.title.split(" ").each do |tag|
          create_tag(tag)
        end
    end
  end
  
  def set_general_category_for_article
    if(@category == nil)
        @category = Category.find_or_create_by_name(name: 'All')
      end
  end
  
  def save_tags_and_categories_for_article 
    @newTag.each do |tag|
        Posttag.find_or_create_by_tag_id_and_micropost_id(tag_id: tag.id, micropost_id: @micropost.id)
        Tagcategory.find_or_create_by_tag_id_and_category_id(tag_id: tag.id, category_id: Category.find_or_create_by_name(name: "All").id)
        Tagcategory.find_or_create_by_tag_id_and_category_id(tag_id: tag.id, category_id: @category.id)
    end
    @newTag.clear
  end

  def destroy
    Userpost.where(user_id: current_user, micropost_id: @micropost.id).destroy_all
    redirect_to root_url
  end

  private
  
  def check_if_url_is_valid
    params[:micropost].each do |k,v|
      if(!validate_url(v))
        redirect_to root_url
        flash[:error] = "Invalid URL #{v}"
        return
      end
    end
  end
  
  def validate_url(url)
    if url =~ VALID_URL_REGEX
      return true
    else
      return false
    end
  end

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_url if @micropost.nil?
  end
  
  def check_if_site_is_valid(url)
    
  end

  def parse(url)
    site = URI.parse("#{url}").host
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari' 
    begin
     html = agent.get("#{url}").body
    rescue => e
      case e.message
        when /404/ 
          return false
        when /500/ 
          return false
        else 
          return false
      end
    end
    doc = Nokogiri.HTML(html, nil)
    parse_parameters(doc, site)
    return true
  end
  
  def parse_meta_attribute(meta, type, site)
    case meta.attribute(type)
      when /^(.*)author$/
        @micropost.author ||= "#{meta.attribute("content")}"
      when /^(.*)description$/
        @micropost.description = "#{meta.attribute("content")}"
      when /^(.*)thumbnail$/
        @micropost.picture ||= "#{meta.attribute("content")}"
      when /^(.*)image$/
        @micropost.picture ||= "#{meta.attribute("content")}"
      when /^(.*)title$/
        @micropost.title ||= "#{meta.attribute("content")}"
      when /^(.*)url$/
        @micropost.url ||= "#{meta.attribute("content")}"
      when /^(.*)site_name$/
        @micropost.server = Server.find_or_create_by_url(url: site, name: "#{meta.attribute("content")}")
      when /^(.*)keywords$/
        "#{meta.attribute("content")}".split(",").each do |tag|
          create_tag(tag)
        end
      when /^(.*)category$/
        @category = Category.find_or_create_by_name(name: "#{meta.attribute("content")}")
        @micropost.category = "#{meta.attribute("content")}"
    end
  end
  
  def create_tag(tag)
    tag.gsub!(/\W+/, '')
    # if(tag.lang == "en")
      # tag.stem
    # end
    if(tag.length > 6)
       @newTag << Tag.find_or_create_by_name(name: "#{tag}")
    end
  end
  
  def parse_parameters(doc, site)  
    doc.css('meta').each do |meta|
      if meta.attribute("name")
        parse_meta_attribute(meta,"name", site)
      elsif meta.attribute("property")
        parse_meta_attribute(meta,"property", site)
      end
    end
    
    limit_description_length
    if(@micropost.category == nil || @micropost.category.length < 1)
     @micropost.category = "All"
    end
  end
  
  def limit_description_length
      @micropost.description.slice! 300..-1
      @micropost.description += "..."
  end
  
end