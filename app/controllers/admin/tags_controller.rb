class Admin::TagsController < ApplicationController
  before_filter :require_admin
  def index
    @tags = Tag.order('tier, tag')
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(permitted_params)
    if @tag.save
      redirect_to [ :admin, :tags], notice: 'created'
    else
      @tags = Tag.order('tier, tag')
      render :index
    end
  end

  def edit
    @tag = Tag.where(tag: params[:id]).first!
    render '_form'
  end

  def update
    @tag = Tag.where(tag: params[:id]).first!
    if @tag.update_attributes(permitted_params)
      redirect_to [ :admin, :tags], notice: 'created'
    else
      render '_form'
    end
  end

  def destroy
    @tag = Tag.where(tag: params[:id]).first!
    @tag.destroy!
    redirect_to [:admin, :tags], notice: 'deleted'
  end

  private

  def permitted_params
    params.require(:tag).permit(:tag, :tier)
  end
end
