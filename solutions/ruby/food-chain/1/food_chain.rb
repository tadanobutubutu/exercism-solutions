class FoodChain
  def self.song
    verses = []
    verses << verse_fly
    verses << verse_spider
    verses << verse_bird
    verses << verse_cat
    verses << verse_dog
    verses << verse_goat
    verses << verse_cow
    verses << verse_horse
    verses.join("\n\n") + "\n"
  end

  def self.verse_fly
    <<~VERSE.chomp
      I know an old lady who swallowed a fly.
      I don't know why she swallowed the fly. Perhaps she'll die.
    VERSE
  end

  def self.verse_spider
    <<~VERSE.chomp
      I know an old lady who swallowed a spider.
      It wriggled and jiggled and tickled inside her.
      She swallowed the spider to catch the fly.
      I don't know why she swallowed the fly. Perhaps she'll die.
    VERSE
  end

  def self.verse_bird
    <<~VERSE.chomp
      I know an old lady who swallowed a bird.
      How absurd to swallow a bird!
      She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
      She swallowed the spider to catch the fly.
      I don't know why she swallowed the fly. Perhaps she'll die.
    VERSE
  end

  def self.verse_cat
    <<~VERSE.chomp
      I know an old lady who swallowed a cat.
      Imagine that, to swallow a cat!
      She swallowed the cat to catch the bird.
      She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
      She swallowed the spider to catch the fly.
      I don't know why she swallowed the fly. Perhaps she'll die.
    VERSE
  end

  def self.verse_dog
    <<~VERSE.chomp
      I know an old lady who swallowed a dog.
      What a hog, to swallow a dog!
      She swallowed the dog to catch the cat.
      She swallowed the cat to catch the bird.
      She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
      She swallowed the spider to catch the fly.
      I don't know why she swallowed the fly. Perhaps she'll die.
    VERSE
  end

  def self.verse_goat
    <<~VERSE.chomp
      I know an old lady who swallowed a goat.
      Just opened her throat and swallowed a goat!
      She swallowed the goat to catch the dog.
      She swallowed the dog to catch the cat.
      She swallowed the cat to catch the bird.
      She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
      She swallowed the spider to catch the fly.
      I don't know why she swallowed the fly. Perhaps she'll die.
    VERSE
  end

  def self.verse_cow
    <<~VERSE.chomp
      I know an old lady who swallowed a cow.
      I don't know how she swallowed a cow!
      She swallowed the cow to catch the goat.
      She swallowed the goat to catch the dog.
      She swallowed the dog to catch the cat.
      She swallowed the cat to catch the bird.
      She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.
      She swallowed the spider to catch the fly.
      I don't know why she swallowed the fly. Perhaps she'll die.
    VERSE
  end

  def self.verse_horse
    <<~VERSE.chomp
      I know an old lady who swallowed a horse.
      She's dead, of course!
    VERSE
  end
end
