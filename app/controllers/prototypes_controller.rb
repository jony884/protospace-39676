class PrototypesController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_prototype, only: [:edit, :show]
  # before_action :authenticate_user!
  before_action :move_to_index, only: [:edit, :update]
  
  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      flash[:success] = "プロトタイプが保存されました。"
      redirect_to prototypes_path # 一覧ページへのリダイレクト
    else
      render 'new'
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to prototypes_path, notice: 'プロトタイプが削除されました'
  end


  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit
    end
  end
    
  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image, :user_id).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id]) 
  end

  def move_to_index
    @prototype = Prototype.find(params[:id]) 
    unless current_user == @prototype.user
      redirect_to user_session_path
    end
  end
end
