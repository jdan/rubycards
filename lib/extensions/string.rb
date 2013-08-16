class String
  # Places a string to the right of the current string
  #
  # Example:
  #   ab        ef      abef
  #   cd .next( gh ) => cdgh
  #
  # @param str [String] The string to place adjacent
  # @return [String] The constructed string
  def next(str)
    # zip the two strings, split by line breaks
    zipped = self.split("\n").zip(str.split("\n"))

    # map the zipped strings, by joining each pair and ending
    #   with a new line, then joining the whole thing together
    zipped.map { |e| "#{e.join}" }.join "\n"
  end

end
