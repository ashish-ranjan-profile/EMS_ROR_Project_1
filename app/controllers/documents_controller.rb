# app/controllers/documents_controller.rb
class DocumentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_document, only: %i[show edit update destroy]

  # GET /documents
  def index
    @documents = Document.all
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # POST /documents
  def create
    @document = Document.new(document_params)
    if @document.save
      redirect_to documents_path, notice: "Document was successfully created."
    else
      flash.now[:alert] = "Document creation failed."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /documents/:id
  def show; end

  # GET /documents/:id/edit
  def edit; end

  # PATCH/PUT /documents/:id
  def update
    if @document.update(document_params)
      redirect_to documents_path, notice: "Document was successfully updated."
    else
      flash.now[:alert] = "Document update failed."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /documents/:id
  def destroy
    if @document.destroy
      redirect_to documents_path, notice: "Document was deleted successfully."
    else
      redirect_to documents_path, alert:  "Failed to delete document."
    end
  end

  private

  def document_params
    params.require(:document).permit(:name, :doc_type, :employee_id, :file)
  end

  def set_document
    @document = Document.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to documents_path, alert: e.message
  end
end
