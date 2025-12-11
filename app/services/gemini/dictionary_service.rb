module Gemini
  class DictionaryService
    SYSTEM_PROMPT = <<~PROMPT.freeze
      You are a professional bilingual dictionary.
      You can receive Japanese or English.
      If input is Japanese, translate to natural English.
      If input is English, translate to natural Japanese.
      Output must be JSON with the following structure:

      {
        "translation": { "jp": "string", "en": "string" },
        "definition": { "jp": "string", "en": "string" },
        "example": { "jp": "string", "en": "string" },
        "synonyms": string[] | [],
        "antonyms": string[] | [],
        "etymology": string,
        "part_of_speech": string,
        "collocations": string[]
      }
      Rules:
      - Return an array: [ {…}, {…} ]
      - If input has multiple translation or part of speech, they must be a separate object
      - Always include all keys.
      - If no values exist, return an empty array [] or empty string "".
      - Do not include any explanation.
      - If input is Japanese, "jp" in translation must be the input.
      - If input is English, "en" in translation must be the input.

      About synonyms, antonyms, etymology, part of speech and collocations:
      - If input is English, they must be those of the input.
      - If input is Japanese, they must be those of the translated english expression.

      Allowed part of speech labels:
      "noun","verb","adjective","adverb","phrase","idiom","auxiliary verb",
      "conjunction","pronoun","preposition","article","other"
    PROMPT

    def self.call(word)
      # Geminiクライアントに処理委譲
      Gemini::Client.call(
        system_instruction: SYSTEM_PROMPT,
        input: word
      )
    end
  end
end
