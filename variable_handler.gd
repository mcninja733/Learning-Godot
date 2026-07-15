extends Node3D


#Main player stats

#Perma stats
var race := "N/A"
var magic_affinity := 0

#Changeable stats
var move_speed := 3.0
var acceleration := 20.0
var rotation_speed := 12.0
var jump_power := 12.0
var player_gravity := -30.0






#Behind the scenes

#"Enabled" variables
var camera_enabled := true
var movement_enabled := true



# Race rolling function that is called upon from main menu for now

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
