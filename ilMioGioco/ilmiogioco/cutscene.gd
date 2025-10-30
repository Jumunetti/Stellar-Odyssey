extends Node2D



# Lista immagini
var images = [
	preload("res://scenes/Cutscene/c1.jpg"),
	preload("res://scenes/Cutscene/c2.png"),
	preload("res://scenes/Cutscene/c3.png"),
	preload("res://scenes/Cutscene/c4.png"),
	preload("res://scenes/Cutscene/c5.png")
]


# Lista dialoghi (stesso ordine delle immagini)
var dialogs = [
	"Ciao, eroe! Benvenuto nella nostra storia...",
	"Questa terra è stata colpita da una grande oscurità.",
	"Solo tu puoi riportare la luce.",
	"Preparati... l’avventura sta per iniziare.",
	"Buona fortuna!"
]

var current_index = 0
var typing = false

@onready var image_display = $ImageDisplay
@onready var dialog_label = $Control/DialogBox/DialogText

func _ready():
	# Mostra la prima scena
	show_scene(current_index)

func _input(event):
	# Avanza con la barra spaziatrice
	if event.is_action_pressed("ui_accept") and not typing:
		current_index += 1
		if current_index < images.size():
			show_scene(current_index)
		else:
			# Fine cutscene → vai al gioco
			get_tree().change_scene("res://Gameplay.tscn")

func show_scene(index):
	image_display.texture = images[index]
	start_typing(dialogs[index])

# ------------------------------
# Effetto scrittura lenta
# ------------------------------
func start_typing(new_text: String):
	typing = true
	dialog_label.text = ""
	for i in new_text.length():
		dialog_label.text += new_text[i]
		await get_tree().create_timer(0.05).timeout # velocità scrittura
	typing = false
