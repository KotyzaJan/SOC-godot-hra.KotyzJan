extends CharacterBody2D
# Jméno
class_name Hrac

# Odkazy na komponenty
@onready var animace = $PrehravacAnimaci
@onready var obrazek = $Obrazek
@onready var kolize_utoceni = $MistoUtoceni/KolizeUtoceni
@onready var zvuk_skoku = $MistoUtoceni/Zvuky/ZvukSkoku

# Proměnné, které jdou upravit v inspektoru.
@export var utoceni = false
@export var hit = false
@export var rychlost = 110

# Proměnné
var maximalni_zdravi = 3
var zdravi = 0
var muze_dostat_damage = true
var pocet_klicu = 0

# Konstanty
const sila_skoku = -280.0

# Vezme gravitaci z project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Funkce co proběhne na začátku
func _ready():
	zdravi = maximalni_zdravi

# Funkce proces (probíhá pořád)
func _process(_delta):
	if Input.is_action_just_pressed("utok") && !hit:
		utok()
	
# Upravená funkce proces pro fungování fyziky
func _physics_process(delta):
	
	# Přidání gravitace
	if not is_on_floor():
		velocity.y += gravity * delta

	# Skok
	if Input.is_action_just_pressed("skok") and is_on_floor():
		velocity.y = sila_skoku
		zvuk_skoku.play()
		Skore.skoky += 1
	

	# Proměnná směr pro pohyb vlevo a vpravo
	var smer = Input.get_axis("pohyb_vlevo", "pohyb_vpravo")
	
	#Otáčení hráče
	if smer > 0:
		obrazek.flip_h = false
		kolize_utoceni.position.x = abs(kolize_utoceni.position.x) * 1
	elif smer < 0:
		obrazek.flip_h = true
		kolize_utoceni.position.x = abs(kolize_utoceni.position.x) * -1
	
	# Nastavení pohybu
	if smer:
		velocity.x = smer * rychlost
	else:
		velocity.x = move_toward(velocity.x, 0, rychlost)
		
	# Smrt pádem
	if position.y > 100:
		smrt()
		
	# Volání funkcí
	move_and_slide()
	obnoveni_animaci()
	
func utok():
	var prekryvane_objekty = $MistoUtoceni.get_overlapping_areas()
	
	for area in prekryvane_objekty:
		if area.get_parent().is_in_group("Nepratele"):
			area.get_parent().dostat_damage(1)
	utoceni = true
	animace.play("Utok")
	
# Funkce pro obnovení animací
func obnoveni_animaci():
	# Když neutočí
	if !utoceni && !hit:
		# Nejdříve kontrolujeme, jestli je hráč ve vzduchudd
		if velocity.y < 0:
			animace.play("Skok")
		elif velocity.y > 0:
			animace.play("Pad")
			
		# Poté kontrolujeme horizontální pohyb
		elif velocity.x != 0:
			animace.play("Beh")
		else:
			animace.play("Normalni")
			
# Funkce pro damage
func dostat_damage(velikost_damage):
	if muze_dostat_damage:
		imunita_damage()
	
		hit = true
		utoceni = false
		animace.play("Damage")
	
		zdravi -= velikost_damage
		
		if zdravi <= 0:
			animace.play("Smrt")
			
# Funkce pro imunitu po dostání damage
func imunita_damage():
	muze_dostat_damage = false
	await get_tree().create_timer(1).timeout
	muze_dostat_damage = true
	
# Funkce pro smrt
func smrt():
	queue_free()
	pocet_klicu = 0
	print(pocet_klicu)
	Skore.smrti += 1
	get_tree().call_deferred("reload_current_scene")
