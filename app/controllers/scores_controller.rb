class ScoresController < ApplicationController
  before_action :set_score, only: %i[ show edit update destroy ]

  # GET /scores or /scores.json
  def index
    @scores = Score.all
  end

  # GET /scores/1 or /scores/1.json
  def show
    puts 'saaaaaaaaaaaaa'
    if session[:whichp]
      puts 'yessssssssss'
      @dest = "/students/"+session[:studentid]+"/edit_score"
    else
      puts 'noooooooooooo'
      @dest = scores_path
    end
  end

  # GET /scores/new
  def new
    @score = Score.new
    if(params.has_key?(:from))
      puts "dsdss"
      session[:whichp] = true
      @dest = "/students/"+session[:studentid]+"/edit_score"
    else
      @dest = scores_path
      puts "no"
     
    end
  end

  # GET /scores/1/edit
  def edit
    if session[:whichp]
      puts 'yessssssssss'
      @dest = "/students/"+session[:studentid]+"/edit_score"
    else
      puts 'noooooooooooo'
      @dest = scores_path
    end
    if(params.has_key?(:from))
      puts "dsdss"
      session[:whichp] = true
      @dest = "/students/"+session[:studentid]+"/edit_score"
    else
      puts "no"
     
    end
  end

  # POST /scores or /scores.json
  def create
    @score = Score.new(score_params)

    respond_to do |format|
      if @score.save
        format.html { redirect_to score_url(@score), notice: "Score was successfully created." }
        format.json { render :show, status: :created, location: @score }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1 or /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
       
        format.html { redirect_to score_url(@score), notice: "Score was successfully updated." }
        format.json { render :show, status: :ok, location: @score }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1 or /scores/1.json
  def destroy
    @score.destroy

    respond_to do |format|
      format.html { redirect_to scores_url, notice: "Score was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def relay
    puts 'WTFFFFFFFFF'
    commit = params[:commit]
    indexs = params[:index]
 
    if( commit == "Edit")
     
      session[:studentid] = params[:studentid]
      redirect_to :controller => 'scores', :action => 'edit',:id => indexs,from: 'yo'
    elsif (commit == "Delete")
      Score.find(indexs).destroy
      session[:studentid] = params[:studentid]
      redirect_to  "/students/"+session[:studentid]+"/edit_score"
    elsif (commit == "Add")
      session[:studentid] = indexs
      redirect_to :controller=>'scores',:action=>'new',from: 'yo'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def score_params
      params.require(:score).permit(:subject, :point, :grade, :class_year, :student_id)
    end
end
