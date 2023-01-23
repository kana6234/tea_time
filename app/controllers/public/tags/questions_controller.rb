class Public::Tags::QuestionsController < ApplicationController
  def index
    @tags = Tag.eager_load(:questions).where.not(questions: { id: nil}).sort {|a,b| b.questions.size <=> a.questions.size}
  end

  def show
    tag = Tag.find(params[:id])
    @questions = tag.questions
    @question = @questions.recent.page(params[:page])
  end
end
