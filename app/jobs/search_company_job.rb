class SearchCompanyJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    search_id = args[0]
    search = Search.find(search_id)
    fame  = Fame.new(search)
    search.new_result(note: fame.note, data: fame.data, name: 'fame')

    innovation = Innovation.new(search)
    search.new_result(note: innovation.note, data: innovation.data, name: 'innovation')

    boss = Boss.new(search)
    search.new_result(note: boss.note, data: boss.data, name: 'boss')

    search.status = 'done'
    search.save!


  end
end
