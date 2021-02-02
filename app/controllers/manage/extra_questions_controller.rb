class Manage::ExtraQuestionsController < Manage::ApplicationController
  before_action :require_director

  def index
    @extra_questions = ExtraQuestion.all
  end

  def edit
    @extra_question = ExtraQuestion.find(params[:id])
  end

  def update
    @extra_question = ExtraQuestion.find(params[:id])
    if @extra_question.update_attributes(extra_question_params)
      redirect_to manage_extra_questions_path
    else
      render "new"
    end
  end

  def new
    @extra_question = ExtraQuestion.new
  end

  def create
    @extra_question = ExtraQuestion.new(extra_question_params)
    if @extra_question.save
      redirect_to manage_extra_questions_path
    else
      render "new"
    end
  end

  def destroy
    @extra_question = ExtraQuestion.find(params[:id])
    if @extra_question.destroy
      redirect_to manage_extra_questions_path
    else
      render "edit"
    end
  end

  def extra_question_params
    params.require(:extra_question).permit(
        :question, :data_type, :required, :placeholder, select_collection: []
    )
  end
end
