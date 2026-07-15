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
	# Changes how far before te slide and move stats to slide downwards
	floor_max_angle = deg_to_rad(60.0)
	if VariableHandler.camera_enabled:
		_camera_pivot.rotation.x -= _camera_input_direction.y * delta
		_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
		_camera_pivot.rotation.y -= _camera_input_direction.x * delta
		_camera_input_direction = Vector2.ZERO

# based on the funtion turns those into either coordinates 2D wise like 1,0
	var raw_input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x

# move_direction is just the basis along with the actual input combined together
# move_direction.y also becomes 0.0 to disable moving up and down too
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()


	# For future reference, velocity.y is returned passed zero inside of the last line.
	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(move_direction * VariableHandler.move_speed, VariableHandler.acceleration * delta)
	velocity.y = y_velocity + VariableHandler.player_gravity * delta
	
	# The original variable created helps determine if the conditions to jump are right
	# Afterwards if it comes back as true, it sets velocity of how far we are going up to 12 allowing us to go up and then
	# as gravity subtracts to it(along with delta multiplied by it) it slows down the jump until eventually we fall down.
	var _is_starting_jump := Input.is_action_just_pressed("jump") and is_on_floor()
	if _is_starting_jump:
		velocity.y += VariableHandler.jump_power
	
	if VariableHandler.movement_enabled:
		move_and_slide()
