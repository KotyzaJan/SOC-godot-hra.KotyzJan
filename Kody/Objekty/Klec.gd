extends StaticBody2D

# Odkazy na komponenty
@onready var zvuk_otevreni = $Zvuky/ZvukOtevreni

# Funkce pro otevreni klece
func _on_zona_otevreni_body_entered(body):
	if body is Hrac && body.pocet_klicu < 0:
		body.pocet_klicu = 0
		zvuk_otevreni.play()
		await get_tree().create_timer(0.3).timeout
		queue_free()

