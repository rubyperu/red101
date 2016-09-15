class QuestionsController < ApplicationController
  include Rest

  def index
    @questions = Question.page(params[:page])
  end

  private

  def permitted_attributes
    %i(content topic_id).push(options_attributes: %i(content correct))
  end
end
