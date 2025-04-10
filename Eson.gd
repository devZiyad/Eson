"""
Eson - JSON Data Manager (v2)
-----------------------------

Author: devZiyad  
GitHub: https://github.com/devZiyad  
Date: Wed, April 10, 2025  
Version: 2.0  
Description: A utility class for loading, saving, and managing nested JSON data in Godot.  
			 Supports dot-style key access (e.g., "settings:graphics:resolution").

License: GNU General Public License (GPL) v3.0

Disclaimer: This script is provided as-is without any warranties or guarantees.
Use it at your own risk.
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


func get_value(key: String) -> Variant:
	if not key.contains(":"):
		return json_data.get(key)
	var keys: PackedStringArray = key.split(":")
	var valueptr: Variant = json_data.get(keys[0])
	var index: int = 1
	while (valueptr != null and typeof(valueptr) == TYPE_DICTIONARY and index < keys.size()):
		valueptr = valueptr.get(keys.get(index))
		index += 1
	return valueptr


func set_value(key: String, value: Variant) -> bool:
	if not key.contains(":"):
		json_data[key] = value
		return (key_exists(key) and (get_value(key) == value))
	
	var keys: PackedStringArray = key.split(":")
	var dictptr: Dictionary = json_data.get_or_add(keys[0], {})
	var index: int = 1
	while ((dictptr != null) and (typeof(dictptr) == TYPE_DICTIONARY) and (index < (keys.size() - 1))):
		dictptr = dictptr.get_or_add(keys.get(index), {})
		index += 1
	dictptr.set(keys.get(index), value)
	return (dictptr.has(keys.get(index)) and (get_value(key) == value))


func delete_key(key: String) -> void:
	if not key.contains(":"):
		json_data.erase(key)
		return
	var keys: PackedStringArray = key.split(":")
	var dictptr: Dictionary = json_data.get(keys[0])
	var index: int = 1
	while ((dictptr != null) and (typeof(dictptr) == TYPE_DICTIONARY) and (index < (keys.size() - 1))):
		dictptr = dictptr.get(keys.get(index))
		index += 1
	dictptr.erase(keys.get(index))


func key_exists(key: String) -> bool:
	return (get_value(key) != null)


func get_all_keys(reversed: bool = false) -> Array:
	if !reversed:
		return json_data.keys()
	var data_temp: Array = json_data.keys()
	data_temp.reverse()
	return data_temp


func get_all_values(reversed: bool = false) -> Array:
	if !reversed:
		return json_data.values()
	var data_temp: Array = json_data.values()
	data_temp.reverse()
	return data_temp


func clear_data() -> bool:
	json_data.clear()
	return json_data.is_empty()
