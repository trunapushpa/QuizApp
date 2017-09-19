class TakequizController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.cqid != 0
      redirect_to takequiz_continue_path
    end
    @questions = Question.all
    @genres = Genre.all
    @subgenres = Subgenre.all
  end

  def continue
    if current_user.cqid == 0
      redirect_to takequiz_path
    end
  end

  def continuepost
    if params[:arr]["contopt"] == "Yes"
      redirect_to take_quiz_by_ques_path(current_user.cqid, current_user.cqqid)
    else
      current_user.cqid = 0
      current_user.cqqid = 0
      current_user.cqscore = 0
      current_user.save
      redirect_to takequiz_path
    end
  end

  def show
    @array = current_user.subgenre_ids
    if @array.include?(params[:id].to_i)
      redirect_to takequiz_path, notice: 'You have already taken this quiz.'
    else
      if !(Subgenre.find(params[:id]).questions.first)
        redirect_to takequiz_path, notice: 'Quiz is empty.'
      else
        current_user.cqid = params[:id].to_i
        current_user.cqscore = 0
        current_user.cqqid = Subgenre.find(params[:id]).questions.first.id
        current_user.save
        redirect_to take_quiz_by_ques_path(params[:id], current_user.cqqid)
      end
    end
  end

  def ques
    @subgenre = Subgenre.find(params[:id])
    if @subgenre.id != current_user.cqid
      redirect_to takequiz_path
    else
      @subgenreqs = @subgenre.questions
      @question = @subgenreqs.find(params[:ques])
      if @question
        @last = false
        current_user.cqqid = @question.id
        current_user.save

        if @question == @subgenre.questions.last
          @last = true
        end
      else
        redirect_to takequiz_path
      end
    end
  end

  def next
    @correct = true
    @subgenre = Subgenre.find(params[:id])
    @subgenreqs = Subgenre.find(params[:id]).questions
    @question = Question.find(params[:ques])

    if @question.correct1
      if params[:arr]['1'].to_i == 0
        @correct = false
      end
    end
    unless @question.correct1
      if params[:arr]['1'].to_i == 1
        @correct = false
      end
    end
    if @question.correct2
      if params[:arr]['2'].to_i == 0
        @correct = false
      end
    end
    unless @question.correct2
      if params[:arr]['2'].to_i == 1
        @correct = false
      end
    end
    if @question.correct3
      if params[:arr]['3'].to_i == 0
        @correct = false
      end
    end
    unless @question.correct3
      if params[:arr]['3'].to_i == 1
        @correct = false
      end
    end
    if @question.correct4
      if params[:arr]['4'].to_i == 0
        @correct = false
      end
    end
    unless @question.correct4
      if params[:arr]['4'].to_i == 1
        @correct = false
      end
    end
    if @correct
      current_user.cqscore += 10
    end
    current_user.cqqid = @question.id
    current_user.save
    @subgenre = Subgenre.find(params[:id])
    @nextquestion = @subgenre.questions.where("id > ?", params[:ques]).first
    if @nextquestion
      redirect_to take_quiz_by_ques_path(params[:id], @nextquestion.id)
    else
      @array = current_user.subgenre_ids
      if @array.include?(params[:id].to_i)
        redirect_to takequiz_path, notice: 'You have already taken this quiz.'
      end
      @quizdone = Quiztaken.new
      @quizdone.subgenre_id=params[:id].to_i
      @quizdone.user_id=current_user.id
      @quizdone.score=current_user.cqscore
      @quizdone.save
      current_user.cqscore=0
      current_user.cqqid=0
      current_user.cqid=0
      current_user.save
      @correct = (@quizdone.score)/10
      @incorrect = @subgenre.questions.count - @correct
      session[:correct] = @correct
      session[:incorrect] = @incorrect
      redirect_to dashboard_index_path, notice: "Quiz Completed Successfully. You scored "+ @quizdone.score.to_s + " points.", correct: @correct, incorrect: @incorrect
    end
  end

  def submit
    @questions = Subgenre.find(params[:id]).questions
    @array = current_user.subgenre_ids
    if @array.include?(params[:id].to_i)
      redirect_to takequiz_path, notice: 'You have already taken this quiz.'
    end
    @quizdone = Quiztaken.new
    @quizdone.subgenre_id=params[:id].to_i
    @quizdone.user_id=current_user.id
    @quizdone.score=0
    @questions.each do |question|
        @correct = true
        if question.correct1
          if params[:arr][question.id.to_s]['1'].to_i == 0
            @correct = false
          end
        end
        unless question.correct1
          if params[:arr][question.id.to_s]['1'].to_i == 1
            @correct = false
          end
        end
        if question.correct2
          if params[:arr][question.id.to_s]['2'].to_i == 0
            @correct = false
          end
        end
        unless question.correct2
          if params[:arr][question.id.to_s]['2'].to_i == 1
            @correct = false
          end
        end
        if question.correct3
          if params[:arr][question.id.to_s]['3'].to_i == 0
            @correct = false
          end
        end
        unless question.correct3
          if params[:arr][question.id.to_s]['3'].to_i == 1
            @correct = false
          end
        end
        if question.correct4
          if params[:arr][question.id.to_s]['4'].to_i == 0
            @correct = false
          end
        end
        unless question.correct4
          if params[:arr][question.id.to_s]['4'].to_i == 1
            @correct = false
          end
        end
      if @correct
        @quizdone.score += 10
      end
    end
    @quizdone.save
    redirect_to dashboard_index_path, notice: "Quiz Completed Successfully. You scored "+ @quizdone.score.to_s + " points."
    end
end