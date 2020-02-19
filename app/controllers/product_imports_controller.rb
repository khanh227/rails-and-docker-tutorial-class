class ProductImportsController < ApplicationController
  def import
    @importer = Products::Importor.new(file_import: params[:file])
    if @importer.perform
      flash.notice = @importer.messages
      redirect_to products_path
    else
      flash.error = @importer.messages
    end
  end
end
