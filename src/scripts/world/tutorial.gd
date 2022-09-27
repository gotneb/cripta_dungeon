extends Node2D

const damage_indicator_path := preload("res://scenes/interface/damage_indicator/damage_indicator.tscn")

func _on_Orc_Shaman_health_changed(old_health, new_health):
	var di := damage_indicator_path.instance()
	$OrcShaman.add_child(di)
	di.goes_up(old_health - new_health)
