class SearchCompanyJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    search_id = args[0]
    search = Search.find(search_id)
    scrap  = ScrapLesEchos.new(search)
    result = search.new_result(note: scrap.note, data: scrap.data)
    search.status = 'done'
    search.save!
  end
end
