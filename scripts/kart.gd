extends CharacterBody3D


const MAX_SPEED : float = 70
const ACCEL : float = 1
const FRICTION : float = 1
const MAX_STEER = 2

var vel : Vector3 = Vector3.ZERO
var steer : float = 0
var dir : float = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.get_action_strength("left_steer") + Input.get_action_strength("right_steer") < 0.1:
		steer = lerpf(steer, 0, delta*3)
	else:
		steer = lerpf(steer, ((-Input.get_action_strength("left_steer") + Input.get_action_strength("right_steer")) * -MAX_STEER), delta*2)
	
	$steering_wheel.rotation_degrees.x=steer*-10
	
	rotation_degrees.y = rotation_degrees.y + steer
	dir += steer
	
	if Input.get_action_strength("accelerate") > 0.1:
		vel.x = lerpf(vel.x, MAX_SPEED * Input.get_action_strength("accelerate"), ACCEL * delta)
	else:
		vel.x = lerpf(vel.x, 0, FRICTION * delta)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := (transform.basis * Vector3(1, 0, 0).rotated(Vector3(0, 1, 0), deg_to_rad(90))).normalized() * vel.x/10
	
	velocity.x = direction.x
	velocity.z = direction.z

	move_and_slide()
	
	$wheel.rotation_degrees.z = $wheel.rotation_degrees.z + (vel.x/20)
	$wheel2.rotation_degrees.z = $wheel2.rotation_degrees.z + (vel.x/20)
	$wheel3.rotation_degrees.z = $wheel3.rotation_degrees.z + (vel.x/20)
	$wheel4.rotation_degrees.z = $wheel4.rotation_degrees.z + (vel.x/20)
