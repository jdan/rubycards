class String

  # Places a string to the right of the current string
  #
  # Example:
  #   ab        ef      abef
  #   cd .next( gh ) => cdgh
  def next(str)
    # zip the two strings, split by line breaks
    zipped = self.split("\n").zip(str.split("\n")).map

    # map the zipped strings, by joining each pair and ending
    #   with a new line, then joining the whole thing together
    zipped.map { |e| "#{e.join}\n" }.join
  end

end