extends CharacterBody2D

@export var speed: float = 100.0
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
    var direction = Vector2.ZERO

    if Input.is_action_pressed("move_right"):
        direction.x += 1
    if Input.is_action_pressed("move_left"):
        direction.x -= 1
    if Input.is_action_pressed("move_down"):
        direction.y += 1
    if Input.is_action_pressed("move_up"):
        direction.y -= 1

    direction = direction.normalized()
    velocity = direction * speed
    move_and_slide()

    # Gestione animazioni
    if direction != Vector2.ZERO:
        if direction.x > 0:
            animated_sprite.play("destra")
        elif direction.x < 0:
            animated_sprite.play("sinistra")
        elif direction.y > 0:
            animated_sprite.play("avanti")
        elif direction.y < 0:
            animated_sprite.play("indietro")
    else:
        animated_sprite.stop()
