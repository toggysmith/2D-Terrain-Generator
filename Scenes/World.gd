extends Node2D

func _ready():
	$CanvasLayer/Terrain.texture = TerrainGenerator.get_texture(256, 150, 0, 8, 50.0, 0.55)

func _on_Generate_pressed():
	var width = $GUI/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Width/SpinBox.value
	var height = $GUI/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Height/SpinBox.value
	var chosen_seed = $GUI/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Seed/SpinBox.value
	var octaves = $GUI/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Octaves/SpinBox.value
	var period = $GUI/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Period/SpinBox.value
	var persistence = $GUI/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer2/Persistence/SpinBox.value
	
	$CanvasLayer/Terrain.texture = TerrainGenerator.get_texture(width, height, chosen_seed, octaves, period, persistence)

func _on_WidthSpinBox_value_changed(value):
	$GUI/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Height/SpinBox.value = float(value) * (600.0 / 1024.0)

func _on_HeightSpinBox_value_changed(value):
	$GUI/PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/Width/SpinBox.value = float(value) * (1024.0 / 600.0)
