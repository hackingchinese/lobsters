class FiltersController < ApplicationController
  before_filter :authenticate_user

  def index
    @cur_url = "/filters"
    @title = "Selected Tags"

    @tags = Tag.active.all_with_story_counts_for(@user)
    @filtered_tags = filter_tags

  end

  def update
    tags_param = params[:tags]
    new_tags = tags_param.blank? ? [] :
      Tag.active.where(:tag => tags_param).to_a
    new_tags.keep_if {|t| t.valid_for? @user }

    if @user
      @user.tag_filter_tags = new_tags
    else
      cookies.permanent[TAG_FILTER_COOKIE] = new_tags.map(&:tag).join(",")
    end

    flash[:success] = "Your filters have been updated."

    redirect_to filters_path
  end
end
