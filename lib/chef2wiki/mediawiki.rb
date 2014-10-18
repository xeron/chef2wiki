class Chef2Wiki

  # Add page to MediaWiki
  #
  # ==== Attributes
  # * +title+ - Title of the page (String)
  # * +content+ - Content of the page (String)
  # * +overwrite+ - Overwrite flag (Boolean)
  def add_page(title, content, overwrite = true)
    begin
      print "[MediaWiki]\tCreating page #{title}... "
      wiki.create(title, content, :overwrite => overwrite)
      puts "done."
    rescue Exception => ex
      puts "[MediaWiki]\tError adding page #{title}: " + ex.message.to_s
    end
  end

  private

  # Do wiki connect and login.
  def setup_media_wiki
    if config["wiki"]["api_url"] && !config["wiki"]["api_url"].empty?
      mediawiki = MediaWiki::Gateway.new(config["wiki"]["api_url"])
    else
      abort "[MediaWiki]\tPlease, configure mediawiki api url."
    end

    if config["wiki"]["login"] && !config["wiki"]["login"].empty?
      begin
        mediawiki.login(config["wiki"]["login"], config["wiki"]["password"], config["wiki"]["domain"])
        puts "[MediaWiki]\tLogged in successfully."
      rescue Exception => ex
        puts "[MediaWiki]\tError while login into wiki: " + ex.message.to_s
      end
    end

    return mediawiki
  end

end
