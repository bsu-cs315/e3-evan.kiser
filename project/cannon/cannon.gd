extends RigidBody3D

signal power_changed
signal vertical_angle_changed
signal horizontal_angle_changed
signal projectile_amount_changed
signal no_remaining_projectiles

const _MIN_POWER := 0
const _MAX_POWER := 2000
const _MIN_ANGLE := deg_to_rad(-180)
const _MAX_ANGLE :=deg_to_rad(0)

@export var power := 800.
@export var power_change_rate := 200.
@export var angle_vertical := -TAU/4
@export var angle_horizontal := -TAU/4
@export var angle_change_rate := TAU/8
@export var can_shoot := true
@export var balls_left := 5
var _current_ball : RigidBody3D = null


func _process(delta: float) -> void:
	var power_axis := Input.get_axis("decrease_power", "increase_power")
	if power_axis != 0:
		power += power_axis * power_change_rate * delta
		power = clampf(power, _MIN_POWER, _MAX_POWER)
		power_changed.emit()
		
	var angle_vertical_axis = Input.get_axis("angle_down", "angle_up")
	if angle_vertical_axis != 0:
		angle_vertical += angle_vertical_axis * angle_change_rate * delta
		angle_vertical = clampf(angle_vertical, _MIN_ANGLE, _MAX_ANGLE)
		vertical_angle_changed.emit()
	
	var angle_horizontal_axis = Input.get_axis("angle_left", "angle_right")
	if angle_horizontal_axis != 0:
		angle_horizontal += angle_horizontal_axis * angle_change_rate * delta
		angle_horizontal = clampf(angle_horizontal, _MIN_ANGLE, _MAX_ANGLE)
		horizontal_angle_changed.emit()

	if Input.is_action_just_pressed("launch") and balls_left > 0:
		if _current_ball == null or _current_ball.is_sleeping():
			var impulse := Vector3(1,0,0) * power
			impulse.rotated(Vector3(0,1,0), angle_vertical)
			impulse.rotated(Vector3(0,0,1), angle_horizontal)
			_current_ball = preload("res://ball/ball.tscn").instantiate() as RigidBody3D
			get_parent().add_child(_current_ball)
			_current_ball.global_position = global_position
			_current_ball.apply_impulse(impulse)
			balls_left -= 1
			if balls_left == 0:
				no_remaining_projectiles.emit()
			projectile_amount_changed.emit()
