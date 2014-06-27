class Dictionary

  def initialize(defined_words)
    @defined_words = defined_words
  end

  def parse(word)
    related_words_urls = []
    definition = @defined_words[word]["definition"]
    related_words = (definition.scan /{(.+?)}/).flatten
    related_words.each do |related_word|
      formatted_word = format_word(related_word)
      related_words_urls << @defined_words[formatted_word]["url"]
    end
    {
      :definition => definition.gsub("{", "").gsub("}", ""),
      :see_also => related_words_urls.sort.reverse
    }
  end

  private

  def format_word(word)
    if word[-1] == "s"
      word.chop
    else
      word
    end
  end

end