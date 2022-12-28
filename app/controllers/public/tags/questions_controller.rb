class Public::Tags::QuestionsController < ApplicationController
  def index
    @tags = Tag.joins(:questions).where("questions.id IS NOT NULL").includes(:questions).sort {|a,b| b.questions.size <=> a.questions.size}
  end

  def show
    tag = Tag.find(params[:id])
    @questions = tag.questions
  end
end
