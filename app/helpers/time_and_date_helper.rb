module TimeAndDateHelper
  def time(datetime)
    datetime.strftime('%b %d at %H:%M') unless datetime.nil?
  end
  
  def year(datetime)
    datetime.strftime('%Y') unless datetime.nil?
  end  

  def date(datetime, options = {})
    unless datetime.nil?
      options.reverse_merge!(:year => true)
      format = '%b %d'
      format += ', %Y' if options[:year]
      datetime.strftime(format)
    end
  end
end