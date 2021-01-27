extends Area2D

signal coin_collected

var collected = false

func _on_Coin_body_entered(body):
	if not collected:
		$AnimationPlayer.play("collect")
		emit_signal("coin_collected", self)
		collected = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "collect":
		queue_free()
