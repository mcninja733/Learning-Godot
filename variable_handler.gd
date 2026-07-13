var _race_rarities = {
	Common = 60,
	Rare = 35,
	Legendary = 4.4,
	Mythic = 0.5,
	Primal = 0.1,
}

func race_gacha():
	var _gachanumb = randi_range(1, 1000)
	print(_gachanumb)
	for rarity in _race_rarities:
		_gachanumb -= _race_rarities[rarity] * 10
		
		if _gachanumb <= 0:
			return rarity
