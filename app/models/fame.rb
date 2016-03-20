class Fame
  def initialize(search)
    @company_name = search.company
  end

  def count_les_echos_articles
    end_date = Date.today
    start_date = end_date - 1.year
    @options = {
        query:{
            exec:1,
            page:1,
            jourd:start_date.day,
            moisd:start_date.month,
            anneed:start_date.year,
            jourf:end_date.day,
            moisf:end_date.month,
            anneef:end_date.year,
            texte: @company_name
        }
    }
    page = HTTParty.get('http://recherche.lesechos.fr/recherche.php', @options)
    parse_page = Nokogiri::HTML(page)
    parse_page.css('.bloc-tri').css('.resultats-search').css('strong').text.gsub(/[^0-9]/, '').to_i
  end


  def count_bpi_france_articles
    name = "\"#{@company_name}\""
    url = "http://www.bpifrance.fr/Recherche/(text)/#{URI.encode(name)}"
    page = HTTParty.get(url)
    parse_page = Nokogiri::HTML(page)
    parse_page.css('.menu-filtre-result-count .number-result').text.gsub(/[^0-9]/, '').to_i
  end

  def count_articles
    @count_articles ||= {
        les_echos: count_les_echos_articles,
        bpi_france: count_bpi_france_articles
    }
  end

  def note
    @count = count_articles.values.reduce(&:+)

    case @count
      when 0       then 'F'
      when 1..5    then 'D'
      when 6..10   then 'C'
      when 11..100 then 'B'
      else 'A'
    end
  end

  def data
    count_articles.to_json
  end

end
