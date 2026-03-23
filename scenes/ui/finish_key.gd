extends Area2D
@onready var sfx = $AudioStreamPlayer2D
# Make sure you create a blank scene called "level_2.tscn" in your scenes folder!
var next_level_path = "res://scenes/level/level_2.tscn"

func _on_body_entered(body):
	print("ENTERED:", body.name)

	if body is CharacterBody2D:
		sfx.play()
		get_tree().paused = true
		_generate_victory_ui()

func _generate_victory_ui():
	# 1. Create the CanvasLayer (draws on top of everything)
	var ui_layer = CanvasLayer.new()
	ui_layer.process_mode = Node.PROCESS_MODE_ALWAYS # Keeps UI working while paused
	add_child(ui_layer)

	# Root Control that fills the whole viewport (stable anchor reference)
	var root = Control.new()
	root.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	ui_layer.add_child(root)
	
	# 2. Dark overlay background
	var bg = ColorRect.new()
	bg.color = Color(0, 0, 0, 0.9) # 90% transparent black
	bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_child(bg)
	
	# 3. Center container guarantees centered layout on any resolution
	var center = CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	root.add_child(center)
	
	# 4. Content container
	var container = VBoxContainer.new()
	container.alignment = BoxContainer.ALIGNMENT_CENTER
	container.custom_minimum_size = Vector2(720, 340)
	center.add_child(container)
	
	# 3a. Create the Main Title Text
	var title = Label.new()
	title.text = "LEVEL COMPLETE"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 72)
	title.modulate = Color.WHITE
	container.add_child(title)
	
	# 3b. Add some spacing
	var spacer1 = Control.new()
	spacer1.custom_minimum_size = Vector2(0, 20)
	container.add_child(spacer1)
	
	# 3c. Create the Sarcastic "Taunting" Text
	var label = Label.new()
	label.text = "Wow, you survived.\nIt gets worse."
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 48)
	label.modulate = Color(0.8, 0.8, 0.8) # Lighter gray for secondary text
	label.custom_minimum_size.y = 120
	container.add_child(label)
	
	# 3d. Add spacing before button
	var spacer2 = Control.new()
	spacer2.custom_minimum_size = Vector2(0, 40)
	container.add_child(spacer2)
	
	# 4. Create the "Next Level" Button with better styling
	var button_container = HBoxContainer.new()
	button_container.alignment = BoxContainer.ALIGNMENT_CENTER
	container.add_child(button_container)
	
	var button = Button.new()
	button.text = " CONTINUE "
	button.add_theme_font_size_override("font_size", 42)
	button.custom_minimum_size = Vector2(300, 80)
	
	# Style the button
	var button_stylebox = StyleBoxFlat.new()
	button_stylebox.bg_color = Color.WHITE
	button_stylebox.border_width_left = 3
	button_stylebox.border_width_top = 3
	button_stylebox.border_width_right = 3
	button_stylebox.border_width_bottom = 3
	button_stylebox.border_color = Color.BLACK
	button_stylebox.set_corner_radius_all(8)
	button_stylebox.set_content_margin_all(20)
	button.add_theme_stylebox_override("normal", button_stylebox)
	
	# Hover state
	var button_hover = StyleBoxFlat.new()
	button_hover.bg_color = Color(0.9, 0.9, 0.9)
	button_hover.border_width_left = 3
	button_hover.border_width_top = 3
	button_hover.border_width_right = 3
	button_hover.border_width_bottom = 3
	button_hover.border_color = Color.BLACK
	button_hover.set_corner_radius_all(8)
	button_hover.set_content_margin_all(20)
	button.add_theme_stylebox_override("hover", button_hover)
	
	# Pressed state
	var button_pressed = StyleBoxFlat.new()
	button_pressed.bg_color = Color(0.7, 0.7, 0.7)
	button_pressed.border_width_left = 3
	button_pressed.border_width_top = 3
	button_pressed.border_width_right = 3
	button_pressed.border_width_bottom = 3
	button_pressed.border_color = Color.BLACK
	button_pressed.set_corner_radius_all(8)
	button_pressed.set_content_margin_all(20)
	button.add_theme_stylebox_override("pressed", button_pressed)
	
	# Set text color to black
	button.add_theme_color_override("font_color", Color.BLACK)
	button.add_theme_color_override("font_hover_color", Color.BLACK)
	button.add_theme_color_override("font_pressed_color", Color.BLACK)
	
	# Connect the button click to our function below
	button.pressed.connect(_on_next_level_pressed) 
	button_container.add_child(button)

func _on_next_level_pressed():
	# Unpause the engine and load the next level
	print("BUTTON CLICKED")
	get_tree().paused = false
	get_tree().change_scene_to_file(next_level_path)
