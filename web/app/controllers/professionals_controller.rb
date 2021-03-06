class ProfessionalsController < ApplicationController
  load_and_authorize_resource
  require_relative '../export/export_file.rb'
  # before_action :set_professional, only: %i[ show edit update destroy ]
  # add_flash_types :info, :error, :warning por si se quiere agregar mensaje 

  # GET /professionals or /professionals.json
  def index
    #@professionals = Professional.all
  end

  # GET /professionals/1 or /professionals/1.json
  def show
  end

  # GET /professionals/new
  def new
    @professional = Professional.new
  end

  # GET /professionals/1/edit
  def edit
  end

  # POST /professionals or /professionals.json
  def create
    @professional = Professional.new(professional_params)

    respond_to do |format|
      if @professional.save
        format.html { redirect_to @professional, notice: "Professional was successfully created." }
        format.json { render :show, status: :created, location: @professional }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @professional.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /professionals/1 or /professionals/1.json
  def update
    respond_to do |format|
      if @professional.update(professional_params)
        format.html { redirect_to @professional, notice: "Professional was successfully updated." }
        format.json { render :show, status: :ok, location: @professional }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @professional.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professionals/1 or /professionals/1.json
  def destroy
    begin
      @professional.destroy
      respond_to do |format|
        format.html { redirect_to professionals_url, notice: "Professional was successfully destroyed." }
        format.json { head :no_content }
      end
    rescue => e
      respond_to do |format|
        format.html { redirect_to professionals_url, notice: "#{e.message}" }
        format.json { head :no_content }
      end
    end
  end

  def export_appointments
  end
  
  # en params[:professionals] esta el id del profesional y si no tiene nada es que son todos
  def download_appointments
    p = []
    if params[:professionals].empty?
      @professionals.each do |pro|
        p << pro
      end
    else
      p << Professional.find(params[:professionals])
    end
    send_data ExportFile.export_list(params, p), filename: "appointments_list.pdf", type: "application/pdf"
  end 

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_professional
    #   @professional = Professional.find(params[:id])
    # end 



    # Only allow a list of trusted parameters through.
    def professional_params
      params.require(:professional).permit(:name)
    end

  
end
