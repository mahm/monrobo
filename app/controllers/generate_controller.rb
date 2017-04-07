class GenerateController < ApplicationController
  def index
  end

  def display
    @param = GenerateParameter.create!(data: params)
    respond_to do |format|
      format.js
    end
  end

  def image
    @param = GenerateParameter.find(params[:param_id])
    send_data(Mon::generate(@param.data), type: "image/png", disposition: "inline")
  end
end
