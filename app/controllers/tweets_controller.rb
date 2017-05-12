class TweetsController < ApplicationController
   before_action :authenticate_user!, only: [:index, :create, :update, :destroy]
  
  def index
    # @input_content = Tweet.new
    @input_content = params[:id] ? Tweet.find(params[:id]) : Tweet.new
    @tweet = Tweet.includes(:user).order('updated_at DESC')
    @q = Tweet.search(params[:q])
    @tweets = @q.result.page(params[:page]).per(10).order(:id)
  end
  
  def create
    tweet = Tweet.new
    tweet.attributes = input_content_param
    tweet.user_id = current_user.id
    if tweet.valid?
      tweet.save!
    else
      flash[:alert] = tweet.errors.full_messages
    end
    redirect_to action: :index
  end
  
  # def update 
  #   @tweet =  Tweet.find(params[:id])
  #   tweet.attributes = input_content_param
  #   tweet.user_id = current_user.id
  #   if tweet.valid?
  #     tweet.save!
  #   else
  #     flash[:alert] = tweet.errors.full_messages
  #   end
  #   redirect_to action: :index
  # end

  private
  def input_content_param
    params.require(:tweet).permit(:content)
  end
end
