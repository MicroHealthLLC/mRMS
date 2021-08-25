class CkEditorManagerController < ApplicationController
  def upload_file
    file = params[:upload]
    if file
      content_file = Setting.new
      content_file.content = file
      if content_file.save
        render json: { uploaded: content_file.id, fileName: content_file.content.identifier, url: content_file.content.url }, status: 200
      end
    end
  end
end
