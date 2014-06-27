require './lib/dictionary'

describe Dictionary do

  it 'parses text to return references to other words in the definition' do
    input = {
      "word" => {
        "definition" => "a {collection} of {letters}",
        "url" => "//example.com/word"
      },
      "letter" => {
        "definition" => "a character representing one or more of the sounds used in speech; any of the symbols of an alphabet",
        "url" => "//example.com/letter"
      },
      "collection" => {
        "definition" => "a group of things or people",
        "url" => "//example.com/collection"
      }
    }
    dictionary = Dictionary.new(input)
    expect(dictionary.parse("word")).to eq({
                                             :definition => "a collection of letters",
                                             :see_also => [
                                               "//example.com/letter",
                                               "//example.com/collection"
                                             ]
                                           })
  end

end