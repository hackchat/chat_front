class SearchesController < ApplicationController

  def create
    search = MessageSearch.new(params[:room_id], params[:content], params[:user_token])
    render :json => {results: search.get_results.as_json}
  end

end
