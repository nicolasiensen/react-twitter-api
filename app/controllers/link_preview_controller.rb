class LinkPreviewController < ApplicationController
  def show
    response = RestClient.get(params[:link])
    html = Nokogiri::HTML(response.body)
    render json: { meta: html.css("meta").map(&:to_h) }
  end
end
