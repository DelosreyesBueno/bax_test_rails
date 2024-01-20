class WordService
  @@word_by_token = {}
  @words = []
  
  def self.generate_word
    word = Faker::Lorem.word
    word = Faker::Lorem.word while word.length <= 4

    save_word(word)
    word
  end

  def self.generate_words_key
    uniq_word = order_words.join('')
    key = fibonacci(uniq_word.length).map { |pos| uniq_word[pos] }.join('')
    key
  end

  private
  def self.fibonacci(size)
    sequence = [0, 1]
    while sequence[sequence.length - 1] + sequence[sequence.length - 2] <= size
      sequence.push(sequence[sequence.length - 1] + sequence[sequence.length - 2])
    end

    return sequence
  end

  def self.order_words
    filter_array =  @@word_by_token['words'].compact

    order_array = filter_array.sort do |a, b|
      snd_letter_first = a[1..-1]
      snd_letter_second = b[1..-1]

      if snd_letter_first < snd_letter_second
        -1
      elsif snd_letter_first > snd_letter_second
        1
      else
        0
      end
    end
    order_array
  end

  private

  def self.save_word(word)
    @@word_by_token['words'] = array_words(word)
  end

  def self.array_words(word)
    @words.push(word)
  end
end