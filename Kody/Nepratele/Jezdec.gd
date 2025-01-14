extends CharacterBody2D

# Proměnné
var rychlost = 60
var rychlost_nyni = 0.0
var kouka_doprava = true
var mrtvy = false

var maximum_zdravi = 3
var zdravi = 0

var hit = false
var muze_utocit = true

# Odkazy na komponenty
@onready var detektor = $DetektorZeme
@onready var animace = $PrehravacAnimaci

# Vezme gravitaci z project settings
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Funkce co proběhne na začátku
func _ready():
	zdravi = maximum_zdravi
	animace.play("Beh")

# Upravená funkce proces pro fungování fyziky
func _physics_process(delta):
	
	# Přidání gravitace
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Snímaní země
	if !detektor.is_colliding() && is_on_floor():
		flip()

	# Nastavení pohybu
	velocity.x = rychlost
	move_and_slide()
	
# Funkce pro otáčení
func flip():
	kouka_doprava = !kouka_doprava
	scale.x = abs(scale.x) * -1
	
	if kouka_doprava:
		rychlost = abs(rychlost)
	else:
		rychlost = abs(rychlost) * -1
		
# Funkce dání damage
func _on_hitbox_area_entered(area):
	if area.get_parent() is Hrac && !mrtvy && muze_utocit:
		area.get_parent().dostat_damage(1)
		flip()

# Funkce pro damage
func dostat_damage(velikost_damage):
	if !mrtvy:
		
		animace.play("Damage")
		
		if !kouka_doprava:
			flip()
		
		zdravi -= velikost_damage
		
		if zdravi <= 0:
			smrt()
			
# Funkce pro dostání hitu
func dostat_hit():
	hit = !hit
	
	if hit:
		rychlost_nyni = rychlost
		rychlost = 0
		muze_utocit = false
	else:
		rychlost = rychlost_nyni
		muze_utocit = true
		animace.play("Beh")

# Funkce pro smrt
func smrt():
	rychlost = 0
	animace.play("Smrt")
	mrtvy = true
	
# Funkce skoku na hlavu
func _on_hitbox_hlavy_area_entered(area):
	if area.get_parent() is Hrac:
		dostat_damage(10)
