extends Area2D

# Odkazy na komponenty
@onready var animace = $PrehravacAnimaci

# Funkce pro sebrání klíče
func _on_body_entered(body):
	if body is Hrac:
		animace.play("Sebrani")
		body.pocet_klicu =+ 1
		print(body.pocet_klicu)

