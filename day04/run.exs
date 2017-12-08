defmodule PassphraseValidator do
  def valid?(str) do
    words = split_into_words(str)
    words == Enum.uniq(words)
  end

  def super_valid?(str) do
    words = split_into_words(str)
    alphabetized_words = alphabetize_words(words)
    words == Enum.uniq(words) && alphabetized_words == Enum.uniq(alphabetized_words)
  end

  defp alphabetize_words(words) do
    words |> Enum.map(fn(word) ->
      word |> String.split("") |> Enum.sort |> Enum.join("")
    end)
  end

  defp split_into_words(str) do
    String.split(str)
  end
end

IO.puts "Part 1"
IO.puts " = Quick Tests"
IO.puts "\t'aa bb cc dd ee' => #{PassphraseValidator.valid?("aa bb cc dd ee")} (should be true)"
IO.puts "\t'aa bb cc dd aa' => #{PassphraseValidator.valid?("aa bb cc dd aa")} (should be false)"
IO.puts "\t'aa bb cc dd aaa' => #{PassphraseValidator.valid?("aa bb cc dd aaa")} (should be true)"
IO.puts " = Puzzle Solution"
input = File.read!("input.txt")
lines = input |> String.split("\n") |> Enum.reject(&( &1 == "" ))
total_count = lines |> Enum.count
valid_count = lines |> Enum.filter(&PassphraseValidator.valid?/1) |> Enum.count
IO.puts "\t#{valid_count} valid passphrases out of #{total_count} total"

IO.puts "Part 2"
IO.puts " = Quick Tests"
IO.puts "\t'abcde fghij' => #{PassphraseValidator.super_valid?("abcde fghij")} (should be true)"
IO.puts "\t'abcde xyz ecdab' => #{PassphraseValidator.super_valid?("abcde xyz ecdab")} (should be false)"
IO.puts "\t'a ab abc abd abf abj' => #{PassphraseValidator.super_valid?("a ab abc abd abf abj")} (should be true)"
IO.puts "\t'iiii oiii ooii oooi oooo' => #{PassphraseValidator.super_valid?("iiii oiii ooii oooi oooo")} (should be true)"
IO.puts "\t'oiii ioii iioi iiio' => #{PassphraseValidator.super_valid?("oiii ioii iioi iiio")} (should be false)"
IO.puts " = Puzzle Solution"
super_valid_count = lines |> Enum.filter(&PassphraseValidator.super_valid?/1) |> Enum.count
IO.puts "\t#{super_valid_count} valid passphrases out of #{total_count} total"

