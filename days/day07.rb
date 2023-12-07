require_relative '../lib/aoc'

module Day07
	extend AOC::Day

	@num = 7
	@ans_test1 = 6440
	@ans_test2 = 5905

	CARDS = "23456789TJQKA"
	CARDS_JOKER = "J23456789TQKA"

	def self.solve_part1(input)
		bets = {}
		input.lines.each do |line|
			hand, bet = line.split(" ")
			score = score_hand(hand)
			bets[score] = bet.to_i
		end

		r = 0
		bets.keys.sort.each_with_index do |score, i|
			r += (i+1) * bets[score]
		end
		return r
	end

	def self.solve_part2(input)
		bets = {}
		input.lines.each do |line|
			hand, bet = line.split(" ")
			score = score_hand(hand, true)
			bets[score] = bet.to_i
		end

		r = 0
		bets.keys.sort.each_with_index do |score, i|
			r += (i+1) * bets[score]
		end
		return r
	end

	def self.score_hand(hand, use_jokers = false)
		cards = hand.split("").uniq
		card_occs = {}
		cards.each { |c| card_occs[c] = hand.count(c) }

		jokers = 0
		if use_jokers
			jokers = card_occs["J"] || 0
			card_occs["J"] = 0
		end

		occ_vals = card_occs.values.sort.reverse
		score = ((occ_vals[0]+jokers)*10 + (occ_vals[1] || 0)).to_s
		hand.split("").each do |c|
			score += "%02d" % (use_jokers ? CARDS_JOKER.index(c) : CARDS.index(c))
		end
		return score.to_i
	end
end

Day07.run
