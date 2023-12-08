defmodule Aoc.Day7 do
  def part1 do
    Aoc.get_input("7")
    |> do_part_1
  end

  def part1(inp) do
    do_part_1(inp)
  end

  defp classify_hand(hand) do
    [hand, score] = String.split(hand, " ")
    freq_map = hand |> String.graphemes
    |> Enum.sort
    |> Enum.frequencies
    max_val = Enum.max(Map.values(freq_map))
    min_val = Enum.min(Map.values(freq_map))
    two_pair = Map.values(freq_map) |> Enum.frequencies |> Map.get(2) == 2
    rank = case max_val do
      5 -> :five
      4 -> :four
      3 -> case min_val do
        2 -> :full_house
        1 -> :three
      end
      2 -> case two_pair do
        true -> :two_pair
        false -> :one_pair
      end
      _ -> :high
    end
    {rank, String.graphemes(hand), score}
  end

  defp compare_hands_part_1(hand1, hand2) do
    {hand1, cards1, _score1} = classify_hand(hand1)
    {hand2, cards2, _score2} = classify_hand(hand2)
    hand1 = [:five, :four, :full_house, :three, :two_pair, :one_pair, :high]
    |> Enum.find_index(fn x ->
      x == hand1
    end)
    hand2 = [:five, :four, :full_house, :three, :two_pair, :one_pair, :high]
    |> Enum.find_index(fn x ->
      x == hand2
    end)
    if hand1 == hand2 do
      card_prec = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]
      Enum.reduce_while(Enum.with_index(cards1), true, fn x, _ ->
        {x_val, index} = x
        first = Enum.find_index(card_prec, fn y ->
          x_val == y
        end)
        second = Enum.find_index(card_prec, fn y ->
          Enum.at(cards2, index) == y
        end)

        if first == second do
          {:cont, true}
        else
          {:halt, first < second}
        end
      end)
    else
      hand1 < hand2
    end
  end

  defp do_part_1(inp) do
    String.split(inp, "\n", trim: :true)
    |> Enum.sort(&compare_hands_part_1/2)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(fn {x, index} ->
      {_, _, val} = classify_hand(x)
      {val, _} = Integer.parse(val)
      val * (index + 1)
    end)
    |> Enum.sum
    |> IO.inspect
  end

  def part2 do
    Aoc.get_input("7")
    |> do_part_2
  end

  def part2(inp) do
    do_part_2(inp)
  end

  defp classify_hand_part2(hand) do
    [hand, score] = String.split(hand, " ")
    freq_map = hand |> String.graphemes
    |> Enum.sort
    |> Enum.frequencies
    j_val = Map.get(freq_map, "J")
    freq_map = Map.delete(freq_map, "J")
    max_val = Enum.max(Map.values(freq_map), &>=/2, fn -> 5 end)
    min_val = Enum.min(Map.values(freq_map), &<=/2, fn -> 5 end)
    two_pair = Map.values(freq_map) |> Enum.frequencies |> Map.get(2) == 2

    rank = case max_val do
      5 -> :five
      4 -> :four
      3 -> case min_val do
        2 -> :full_house
        1 -> :three
        _ -> :three
      end
      2 -> case two_pair do
        true -> :two_pair
        false -> :one_pair
      end
      _ -> :high
    end
    rank = case rank do
      :five -> :five
      :four -> case j_val do
        1 -> :five
        _ -> :four
      end
      :full_house -> case j_val do
        2 -> :five
        1 -> :four
        _ -> :full_house
      end
      :three -> case j_val do
        2 -> :five
        1 -> :four
        _ -> :three
      end
      :two_pair -> case j_val do
        1 -> :full_house
        _ -> :two_pair
      end
      :one_pair -> case j_val do
        3 -> :five
        2 -> :four
        1 -> :three
        _ -> :one_pair
      end
      :high -> case j_val do
        5 -> :five
        4 -> :five
        3 -> :four
        2 -> :three
        1 -> :one_pair
        _ -> :high
      end
    end
    {rank, String.graphemes(hand), score}
  end

  defp compare_hands_part_2(hand1, hand2) do
    {hand1, cards1, _score1} = classify_hand_part2(hand1)
    {hand2, cards2, _score2} = classify_hand_part2(hand2)
    hand1 = [:five, :four, :full_house, :three, :two_pair, :one_pair, :high]
    |> Enum.find_index(fn x ->
      x == hand1
    end)
    hand2 = [:five, :four, :full_house, :three, :two_pair, :one_pair, :high]
    |> Enum.find_index(fn x ->
      x == hand2
    end)
    if hand1 == hand2 do
      card_prec = ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]
      Enum.reduce_while(Enum.with_index(cards1), true, fn x, _ ->
        {x_val, index} = x
        first = Enum.find_index(card_prec, fn y ->
          x_val == y
        end)
        second = Enum.find_index(card_prec, fn y ->
          Enum.at(cards2, index) == y
        end)

        if first == second do
          {:cont, true}
        else
          {:halt, first < second}
        end
      end)
    else
      hand1 < hand2
    end
  end

  defp do_part_2(inp) do
    String.split(inp, "\n", trim: :true)
    |> Enum.sort(&compare_hands_part_2/2)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(fn {x, index} ->
      {_, _, val} = classify_hand(x)
      {val, _} = Integer.parse(val)
      val * (index + 1)
    end)
    |> Enum.sum
    |> IO.inspect
  end
end
