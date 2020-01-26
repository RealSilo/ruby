# Remove the highlights of a book from kindle clippings.

# Kindle txt pattern: 

# Tao Te Ching - A Modern Paraphrase (Lao Tzu)
# - Your Highlight on Location 493-493 | Added on Saturday, February 9, 2019 3:07:24 AM

# When something seems too easy, difficulty is hiding in the details.
# ==========

out_file = File.open('My Clippings.txt', 'w')

title = 'The Pocket Oracle and Art of Prudence (Penguin Classics) (Gracián, Baltasar)'
divider = '=========='
blocked_title = false

File.open(File.join(File.dirname(__FILE__), 'my_clippings.txt'), 'r').each_with_index do |line, i|
  blocked_title = true if line.include?(title)
  out_file.print line unless blocked_title
  blocked_title = false if line == divider
end

out_file.close
