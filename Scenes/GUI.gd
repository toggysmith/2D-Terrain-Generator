extends CanvasLayer

func _process(_delta):
	if Input.is_action_just_pressed("toggle_gui"):
		$PanelContainer.visible = !$PanelContainer.visible
		$MarginContainer.visible = !$MarginContainer.visible
