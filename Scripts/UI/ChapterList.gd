extends VBoxContainer

onready var TemplateButton = load("res://Scenes/UI/ChapterButtonTemplate.tscn")
onready var TemplateVolume = load("res://Scenes/UI/VolumeLabelTemplate.tscn")

func _ready():
	pass

func _on_ChapterList_visibility_changed():
	for child in self.get_children():
			child.queue_free()
#	if(get_parent().get_parent().visible):
	for child in self.get_children():
		child.queue_free()
	var Dict = State.Core
	for key in Dict.volumes.keys():
		add_volume(key)
		for chap in Dict["volumes"][key]:
			add_chapter(chap)
#		add_spacing(key)

func add_volume(index):
	var NewLabel = TemplateVolume.instance()
	NewLabel.name = "vol" + index
	NewLabel.text = "\n   Volume " + index
	NewLabel.visible = true
	add_child(NewLabel)

#func add_spacing(index):
#	var NewLabel = TemplateVolume.instance()
#	NewLabel.name = "space" + index
#	NewLabel.text = "          "
#	NewLabel.visible = true
#	add_child(NewLabel)

func add_chapter(number):
	var NewButton = TemplateButton.instance()
	var Dict = State.Core
	NewButton.name = number
	NewButton.text = "Chapter " + number + " - " + Dict["chapters"][number]["title"]["en"]
	NewButton.visible = true
	add_child(NewButton)
