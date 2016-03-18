class SearchController < ApplicationController
  def new
    @search = Search.new
  end

  def do_search
    @company = params[:company]
    @siret = params[:siret]

    @search = Search.create(company:@company, siret: @siret, status: 'searching')
    SearchCompanyJob.perform_later(@search.id)
  end

  def view
    @search = Search.find_by_id(params[:id])
    render json: @search.to_json(:include => [:results])
  end
end
