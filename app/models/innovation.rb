class Innovation
  def initialize(search)
    @company_name = search.company
    @siren = search.siren
  end


  def count_google_patents
    @options = {
        query: {
            tbm:'pts',
            gws_rd:'cr,ssl',
            ei:'A2XtVtfLAcP1aq2Tv_gD#tbm=pts',
            q: "\"#{@company_name}\""
        },
        :verify => false
    }
    page = HTTParty.get("https://www.google.fr/search", @options)
    parse_page = Nokogiri::HTML(page)
    parse_page.css('#resultStats').text.gsub(/[^0-9]/, '').to_i
  end


  def count_inpi_patents
    mechanize = Mechanize.new
    page = mechanize.get('http://bases-brevets.inpi.fr/fr/resultats-recherche-avancee.html')
    form = page.forms.first
    form['tx_jsearchrest_advancedformsearchrest[formSearchRestAdvanced][DEPOSANT]'] = @company_name
    page = mechanize.submit(form, form.submits.first)
    page.search('.results-title').text.gsub(/[^0-9]/, '').to_i
  end

  def count_patents
    @count_patents ||= {
        google: count_google_patents,
        inpi: count_inpi_patents
    }
  end

  def note
    @count = count_patents.values.reduce(&:+)

    case @count
      when 0       then 'F'
      when 1..5    then 'D'
      when 6..10   then 'C'
      when 11..100 then 'B'
      else 'A'
    end
  end

  def data
    count_patents.to_json
  end

end
