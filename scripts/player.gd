extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var area_2d: Area2D = $Area2D

var direction = 1



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	

	# Get the input direction: -1, 0, 1
	if(ray_cast_right.is_colliding()):
		direction = -1
		animated_sprite.flip_h = true
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	if(ray_cast_left.is_colliding()):
		direction = 1
		animated_sprite.flip_h = false
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	if(area_2d.get_overlapping_areas()):
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_VELOCITY
		
	#position.x += direction * SPEED * delta
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
