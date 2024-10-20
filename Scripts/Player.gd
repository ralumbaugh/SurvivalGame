extends CharacterBody3D

var camera : Camera3D
var head : Node3D

var move_speed : float = 5.0
var jump_force : float = 5.0
var gravity : float = 9.0

var look_sens : float = 0.5
var min_x_rot : float = -85.0
var max_x_rot : float = 85.0
var mouse_dir : Vector2

func _ready():
	camera = get_node("Camera3D")
	head = get_node("Head")
	remove_child(camera)
	get_node("/root/Main").add_child.call_deferred(camera)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		camera.rotation_degrees.x += event.relative.y * -look_sens
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, min_x_rot, max_x_rot)
		
		camera.rotation_degrees.y += event.relative.x * -look_sens
	
	
func _process(delta):
	camera.position = head.global_position

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta	
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var dir = camera.basis.z * input.y + camera.basis.x * input.x
	dir.y = 0
	dir = dir.normalized()
	 
	velocity.x = dir.x * move_speed
	velocity.z = dir.z  * move_speed
	
	move_and_slide()
