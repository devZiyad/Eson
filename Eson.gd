"""
Credits and License Information
-------------------------------

Author: devZiyad
GitHub: https://github.com/devZiyad
Date: Sun, August 4 2024
Description: class provides methods for managing JSON data.

License: GNU General Public License (GPL) v3.0

This script is provided as-is without any warranties or guarantees. Use it at your own risk.
"""


class_name Eson


@export var json_data: Dictionary = {}


func load_json(file_path: String) -> bool:
	if !FileAccess.file_exists(file_path):
		return false
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file == null:
		return false
	
	var file_content = file.get_as_text()
	file.close()
	var temp_json = JSON.new()
	var error = temp_json.parse(file_content)
	
	if error != OK:
		return false
	
	if typeof(temp_json.data) != TYPE_DICTIONARY:
		return false
	
	json_data = temp_json.data
	
	return true


func save_json(file_path: String) -> bool:
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	
	if file == null:
		return false
	
	var json_string = JSON.stringify(json_data, "\t", false)
	
	file.store_string(json_string)
	file.close()
	return true


func get_value(key: Variant) -> Variant:
	return json_data.get(key)


func set_value(key: Variant, value: Variant) -> bool:
	json_data[key] = value
	return (key_exists(key) and get_value(key) == value)


func delete_key(key: Variant) -> void:
	json_data.erase(key)


func key_exists(key: Variant) -> bool:
	return json_data.has(key)


func get_all_keys() -> Array:
	return json_data.keys()


func get_all_values() -> Array:
	return json_data.values()


func clear_data() -> void:
	json_data.clear()
