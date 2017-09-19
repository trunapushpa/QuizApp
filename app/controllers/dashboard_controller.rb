class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @sum = 0
    current_user.quiztakens.each do |qt|
      @sum += qt.score
    end
    current_user.score = @sum
    current_user.save
    @quizes = current_user.quiztakens
  end
end
