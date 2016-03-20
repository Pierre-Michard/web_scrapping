class SearchController < ApplicationController
  def welcome
  end

  def new
    @company = params[:company]
    @siren = params[:siren].try(:delete, ' ')
    @siren = nil if @siren == 'siren'

    @search = Search.create(company:@company, siren: @siren, status: 'searching')
    SearchCompanyJob.perform_later(@search.id)
  end

  def view
    @search = Search.find_by_id(params[:id])
    render json: @search.to_json(:include => [:results])
  end
end
