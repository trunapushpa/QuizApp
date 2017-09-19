class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @sum = 0
    current_user.quiztakens.each do |qt|
      @sum += qt.score
    end
    @correct = false
    if session[:correct] != nil
      @correct = session[:correct]
      @incorrect = session[:incorrect]
      session[:incorrect] = nil
      session[:correct] = nil
    end
    current_user.score = @sum
    current_user.save
    @quizes = current_user.quiztakens
  end
end
