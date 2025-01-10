class PromptsController < ApplicationController
  def index
    @prompts = Prompt.all
  end

  def show
    @prompt = Prompt.find(params[:id])
  end

  def new
    @prompt = Prompt.new
  end

  def edit
    @prompt = Prompt.find(params[:id])
  end

  def create
    @prompt = Prompt.new(prompt_params)

    if @prompt.save
      redirect_to @prompt
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @prompt = Prompt.find(params[:id])

    if @prompt.update(prompt_params)
      redirect_to @prompt
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prompt = Prompt.find(params[:id])
    @prompt.destroy

    redirect_to prompts_path, status: :see_other
  end

  private

  def prompt_params
    params.require(:prompt).permit(:title, :text)
  end
end
