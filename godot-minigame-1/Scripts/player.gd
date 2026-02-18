class_name Player
extends CharacterBody3D

const SPEED = 5.5
const ROTATE_SPEED = 3.5
const JUMP_VELOCITY = 6.0
const SPRING_JUMP_VEL = 10.0

var player_spawn_rot
var player_spawn_loc

var points = 0

func _ready() -> void:
	player_spawn_rot = rotation
	player_spawn_loc = position
	_respawn()

func _hitCoin () -> void:
	points += 1;
	print(points)
	%PointsNum._changePoints(points);
	
func _hitSpring () -> void:
	print("hit spring")
	if velocity.y <= 0.0:
		velocity.y = SPRING_JUMP_VEL

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	var rotationAmt := -input_dir.x * ROTATE_SPEED * delta
	rotate_object_local(Vector3(0,1,0), rotationAmt)
	
	var direction := Vector3(0, 0, input_dir.y)
	# if with a vector is checking if all the vector values are >0
	if direction:
		var velXZ := _local_to_global_dir(direction) * SPEED
		velocity.x = velXZ.x
		velocity.z = velXZ.z
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	move_and_slide()
	
func _local_to_global_dir(localDir: Vector3) -> Vector3:
	# space transformations for directions should not consider position
	# to_global assumes you're transforming a position
	return (to_global(localDir) - to_global(Vector3.ZERO)).normalized()
	
func _respawn() -> void:
	position = player_spawn_loc
	rotation = player_spawn_rot
	points = 0
	%PointsNum._changePoints(0);
