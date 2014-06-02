class Referencer

  def initialize(text)
    @text = text
  end

  def related_words(word)
    parsed_text = parse_json(@text)
    word_definition = ""
    references = []
    referenced_urls = []
    parsed_text.each do |entry|
      if entry[0] == word
        word_definition = entry[1]["definition"]
        references = get_references(word_definition)
      end
    end

    parsed_text.each do |entry|
      references.each do |reference|
        if reference[-1] == "s"
          if reference[0..-2] == entry[0]
            referenced_urls << entry[1]["url"]
          end
        elsif reference == entry[0]
          referenced_urls << entry[1]["url"]
        end
      end
    end
    create_references_hash(word_definition, referenced_urls)
  end

  private

  def create_references_hash(word_definition, referenced_urls)
    word_definition.gsub!("{", "")
    word_definition.gsub!("}", "")
    {
      :definition => word_definition,
      :see_also => referenced_urls
    }
  end

  def get_references(word_definition)
    word_definition.scan(/{(.*?)}/).flatten
  end

  def parse_json(text)
    JSON.parse(text)
  end

end