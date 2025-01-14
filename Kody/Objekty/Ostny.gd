extends Area2D

# Funkce pro zabití hráče
func _on_area_entered(area):
	if area.get_parent() is Hrac:
		area.get_parent().dostat_damage(10)



