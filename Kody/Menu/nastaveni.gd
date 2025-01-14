extends Control

@onready var zvuk_skoku = $Zvuky/ZvukSkoku
@onready var zvuk_tlacitka = $Zvuky/ZvukTlacitka
@onready var hlasitost = $"Rámeček/Hlasitost"
@onready var nastaveni = $"."

func _ready():
	hlasitost.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	nastaveni.visible = false
	
func _process(_delta):
	testKonce()

func _on_zpět_do_hry_pressed():
	zvuk_tlacitka.play()
	get_tree().paused = false
	nastaveni.visible = false
	
func _on_hlasitost_value_changed(value):
	AudioServer.set_bus_volume_db(1,linear_to_db(value))

func _on_konec_pressed():
	zvuk_tlacitka.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()

func _on_restart_pressed():
	zvuk_tlacitka.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().call_deferred("reload_current_scene")
	get_tree().paused = false
	
func testKonce():
	if Input.is_action_just_pressed("konec") and !get_tree().paused:
		zvuk_tlacitka.play()
		get_tree().paused = true
		nastaveni.visible = true
	elif Input.is_action_just_pressed("konec") and get_tree().paused:
		zvuk_tlacitka.play()
		get_tree().paused = false
		nastaveni.visible = false
