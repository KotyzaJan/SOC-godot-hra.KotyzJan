extends CanvasLayer

@onready var barevny_obdelnik = $BarevnyObdelnik
@onready var animace = $PrehravacAnimaci

func _ready():
	barevny_obdelnik.visibile = false

func prechod():
	barevny_obdelnik.visible = true
	animace.play("prechod_do_cerne")

func vypnuti():
	barevny_obdelnik.visibile = false
	
func zapnuti():
	barevny_obdelnik.visibile = true
