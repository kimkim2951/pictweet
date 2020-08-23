class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]
  #before_action :move_to_index, except: [:index, :show, :search]
  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
    #binding.pry
    Tweet.create(tweet_params)
  end

  #例えばdestoroyアクションを実行した際にdestoroyのビューが表示されるのは、フォルダとファイルの名前で判断している。
  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = Tweet.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end

  #form_withで受け取った際は、投稿者が送った全部の情報が「tweet」として送られてきている。
  #requireはその「tweet」を選択して、更に、「permit」で必要な「:image,:text」を取得している。
  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
