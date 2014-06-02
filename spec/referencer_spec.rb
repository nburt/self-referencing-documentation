require './lib/referencer'
require 'json'

describe Referencer do

  it 'should parse JSON dictionary text and return related words' do
    text = <<-TEXT
{
  "word": {
    "definition": "a {collection} of {letters}",
    "url": "//example.com/word"
  },
  "letter": {
    "definition": "a character representing one or more of the sounds used in speech; any of the symbols of an alphabet",
    "url": "//example.com/letter"
  },
  "collection": {
    "definition": "a group of things or people",
    "url": "//example.us/collection"
  }
}
    TEXT

    referencer = Referencer.new(text)

    expect(referencer.related_words('word')).to eq({
                                                     definition: "a collection of letters",
                                                     see_also: [
                                                       "//example.com/letter",
                                                       "//example.us/collection"
                                                     ]
                                                   })

  end

end