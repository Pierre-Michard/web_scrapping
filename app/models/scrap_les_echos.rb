class ScrapLesEchos
  def initialize(search)
    @company_name = search.company
  end

  def count_articles
    page = HTTParty.get("http://recherche.lesechos.fr/?exec=1&texte=#{@company_name}")
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
