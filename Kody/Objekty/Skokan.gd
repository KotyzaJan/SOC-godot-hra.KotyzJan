extends Area2D

# Proměnné
@export var síla = -400.0

# Odkazy na komponenty
@onready var animace = $PrehravacAnimaci

# Funkce pro skokan
func _on_body_entered(body):
	if body is Hrac:
		body.velocity.y = síla
		animace.play("Aktivace")
