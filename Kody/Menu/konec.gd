extends Control

@onready var zvuk_tlacitka = $Zvuky/ZvukTlacitka
@onready var smrti = $Smrti
@onready var skoky = $Skoky


func _ready():
	smrti.text = "Zemřel jsi: " + str(Skore.smrti) + "x"
	skoky.text = "Skočil jsi: " + str(Skore.skoky) + "x"

func _on_zacatek_pressed():
	zvuk_tlacitka.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://Scény/Urovne/uroven_1.tscn")

func _on_konec_pressed():
	zvuk_tlacitka.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()

