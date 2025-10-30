extends CanvasLayer

func _ready():
	$VBoxContainer/ButtonGioca.pressed.connect(_on_gioca_pressed)
	$VBoxContainer/ButtonOpzioni.pressed.connect(_on_opzioni_pressed)
	$VBoxContainer/ButtonCrediti.pressed.connect(_on_crediti_pressed)

func _on_gioca_pressed():
	get_tree().change_scene_to_file("res://scenes/Cutscenes/Intro.tscn")

func _on_opzioni_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu/Options.tscn")

func _on_crediti_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu/Credits.tscn")
