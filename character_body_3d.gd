# !!THIS IS A BASIC MOVEMENT SCRIPT ON MY FIRST DAY OF CREATING GODOT SCRIPTS BASED ON PLAYER MOVEMENT LIMITED TO WALKING IN ALL DIRECTIONS< CAMERA MOVEMENT< AND GRAVITY EFFECTS ON THE PLAYER BODY!!

# Lets the script know where its parent is
extends CharacterBody3D

# Creates the variable as well as side editor in inspector that may be changed during testing
@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25


var _camera_input_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %CharacterCamera

# For capturing the mouse whenever the screen is clicked at the
# appropriate time. Exits if esc is pressed.
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

#Detects if there is camera movement
func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity

#Camera movement through mouse movement is here
func _physics_process(delta: float) -> void:
	if VariableHandler.camera_enabled:
		_camera_pivot.rotation.x -= _camera_input_direction.y * delta
		_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
		_camera_pivot.rotation.y -= _camera_input_direction.x * delta
		_camera_input_direction = Vector2.ZERO

	var raw_input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x

	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()



	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(move_direction * VariableHandler.move_speed, VariableHandler.acceleration * delta)
	velocity.y = y_velocity + VariableHandler.player_gravity * delta
	
	if VariableHandler.movement_enabled:
		move_and_slide()
