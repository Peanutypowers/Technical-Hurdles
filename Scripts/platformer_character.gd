extends CharacterBody2D

@export var respawn_point:= Vector2(504, 741)
var speed = 300.0
const JUMP_VELOCITY = -800.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if velocity.y > 0:
		$AnimatedSprite2D.play("fall")
	if velocity.y < 0:
		$AnimatedSprite2D.play("jump")
	
	if is_on_floor():
		$AnimatedSprite2D.play("idle")
	
	if Input.is_action_pressed("run"):
		speed = 500.0
	else:
		speed = 300.0
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.play("walking")
		$AnimatedSprite2D.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		$AnimatedSprite2D.play("walking")

		
	if $".".position.y > 1200:
		$".".position = respawn_point

	move_and_slide()
