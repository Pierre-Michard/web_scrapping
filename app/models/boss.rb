class Boss
  def initialize(search)
    @company_name = search.company
    @siren = search.siren
    @boss_name = find_boss
    @first_name = @boss_name.split[1] unless @boss_name.blank?
    @last_name = @boss_name.split[2].capitalize  unless @boss_name.blank?
  end


  def find_boss
    mechanize = Mechanize.new

    page = mechanize.get('http://www.societe.com/')
    form = page.forms.first
    form['champs'] = @siren || @company_name
    page = mechanize.submit(form, form.submits.first)
    page.search('#dir//.firsttabledir//td[2]').try(:first).try(:text).try(:strip)
  end

  def linked_in_page
    return nil if @first_name.nil? || @last_name.nil?
    mechanize = Mechanize.new {|a| a.ssl_version, a.verify_mode = 'TLSv1', OpenSSL::SSL::VERIFY_NONE}
    page = mechanize.get('https://fr.linkedin.com')
    form = page.forms.third
    form['first'] = @first_name
    form['last'] = @last_name
    page = form.submit.uri
  end


  def note
    (@boss_name.nil? && 'F') || 'A'
  end

  def data
    "<a href=\"#{linked_in_page}\">#{@boss_name}</a>"
  end

end
