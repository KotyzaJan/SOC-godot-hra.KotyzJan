extends Area2D

# Odkazy na komponenty
@onready var zvuk_konce = $Zvuky/ZvukKonce

# Funkce pro dokončení urovně
func _on_body_entered(body):
	if body is Hrac:
		var slozka_soucasne_sceny = get_tree().current_scene.scene_file_path
		var cislo_dalsi_urovne = slozka_soucasne_sceny.to_int() + 1
		var cesta_dalsi_urovne = "res://Scény/Urovne/uroven_" + str(cislo_dalsi_urovne) + ".tscn"
		zvuk_konce.play()
		body.pocet_klicu = 0
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file.call_deferred(cesta_dalsi_urovne)

