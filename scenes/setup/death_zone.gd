extends Area2D
@onready var death_sfx = $DeathSFX

func _on_body_entered(body):
	if body is CharacterBody2D:
		death_sfx.play()
		body.visible = false
		
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
