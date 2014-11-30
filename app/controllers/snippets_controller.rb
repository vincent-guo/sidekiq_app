class SnippetsController < ApplicationController
  def show
    @snippet = Snippet.find(params[:id])
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
      PygmentsWorker.perform_async(@snippet.id)
      redirect_to @snippet
    else
      render :new
    end
  end



  private

  def snippet_params
    params.require(:snippet).permit(:language, :plain_code)
  end
end
