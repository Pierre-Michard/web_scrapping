class ScrapLesEchos
  def initialize(search)
    @company_name = search.company
  end

  def count_articles
    end_date = Date.today
    start_date = end_date - 1.year
    @options = {
        query:{
          jourd:start_date.day,
          moisd:start_date.month,
          anneed:start_date.year,
          jourf:end_date.day,
          moisf:end_date.month,
          anneef:end_date.year,
          text: @company_name
        }
    }
    page = HTTParty.get("http://recherche.lesechos.fr/", @options)
    parse_page = Nokogiri::HTML(page)
    parse_page.css('.bloc-tri').css('.resultats-search').css('strong').text.gsub(/[^0-9]/, '').to_i
  end

  def note
    @count = count_articles
    case @count
      when 0       then 'F'
      when 0..1    then 'E'
      when 2..5    then 'D'
      when 6..10   then 'C'
      when 11..100 then 'B'
      else 'A'
    end
  end

  def data
    "count: #{@count}"
  end

end
