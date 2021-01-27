extends KinematicBody2D

var velocity = Vector2(0, 0)

const SPEED = 100
const GRAVITY = 25
const JUMP_FORCE = 400

func set_animation():
	if is_on_floor():
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			$AnimatedSprite.play("run")
		else:
			$AnimatedSprite.play("idle")
	else:
		$AnimatedSprite.play("jump")

func _physics_process(delta):
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false

	set_animation()

	velocity.y += GRAVITY

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_FORCE

	velocity = move_and_slide(velocity, Vector2.UP)

	velocity.x = lerp(velocity.x, 0, 0.3)
