extends Node3D


func _process(_delta: float) -> void:	
	if $Target.winDetector:
		$WinLabel.text = "You hit the Flag!"
		await(get_tree().create_timer(5).timeout)
		#get_tree().change_scene_to_file("res://title_screen/title_screen.tscn")


func _on_cannon_power_changed() -> void:
	$PowerLabel.text = "Power : %.d" % $Cannon.power
	$PowerLabel.modulate = Color.RED

func _on_cannon_projectile_amount_changed() -> void:
	$ProjectilesLeftLabel.text = "Projectiles Left : %.d" % $Cannon.balls_left
	$ProjectilesLeftLabel.modulate = Color.RED

func _on_cannon_horizontal_angle_changed() -> void:
	$HorizontalAngleLabel.text = "Horizontal Angle : %.d" % rad_to_deg(-1*$Cannon.angle_horizontal)
	$HorizontalAngleLabel.modulate = Color.RED


func _on_cannon_vertical_angle_changed() -> void:
	$VerticalAngleLabel.text = "Vertical Angle : %.d" % rad_to_deg(-1*$Cannon.angle_vertical)
	$VerticalAngleLabel.modulate = Color.RED
