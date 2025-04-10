# Eson - JSON Management Class

## Table of Contents

- [Description](#description)
- [Features](#features)
- [Usage](#usage)
- [License](#license)
- [Contact](#contact)
- [Disclaimer](#disclaimer)

## Description

`Eson` is a class designed for managing JSON data in the Godot Engine. It provides methods for loading JSON from a file, saving JSON to a file, and performing various operations on the JSON data such as retrieving, setting, deleting key-value pairs, and clearing the data.

## Features

- **Load JSON Data**: Load JSON data from a file into the class.
- **Save JSON Data**: Save the current JSON data to a file.
- **Get Value**: Retrieve a value associated with a given key.
- **Set Value**: Set a value for a given key.
- **Delete Key**: Remove a key-value pair from the JSON data.
- **Check Key Existence**: Check if a key exists in the JSON data.
- **Get All Keys**: Retrieve a list of all keys in the JSON data.
- **Get All Values**: Retrieve a list of all values in the JSON data.
- **Clear Data**: Clear all data in the JSON dictionary.

## Usage

### Example

Here is a brief example of how to use the `Eson` class in your Godot project:

```gdscript
extends Node

func _ready():
	var eson = Eson.new()

	# Load JSON data from a file
	if eson.load_json("res://data.json"):
		print("✅ JSON loaded successfully!")

	# Set nested values using colon-delimited keys
	eson.set_value("player:name", "Ziyad")
	eson.set_value("player:stats:score", 1200)
	eson.set_value("player:stats:level", 5)
	eson.set_value("settings:audio:volume", 0.75)

	# Get values using nested keys
	var name = eson.get_value("player:name")
	var score = eson.get_value("player:stats:score")
	var volume = eson.get_value("settings:audio:volume")

	print("👤 Name:", name)
	print("🏆 Score:", score)
	print("🔊 Volume:", volume)

	# Check if nested key exists
	if eson.key_exists("player:stats:level"):
		print("📌 Level key exists!")

	# Delete a nested key
	eson.delete_key("settings:audio:volume")
	print("🗑️ Deleted 'settings:audio:volume'")

	# Save the modified JSON back to the file
	if eson.save_json("res://data.json"):
		print("💾 JSON saved successfully!")

	# Show all root keys (note: does not show nested keys)
	print("📂 Root-level keys:", eson.get_all_keys())

	# Clear everything
	eson.clear_data()
	print("🧹 All data cleared!")

```

## License

This project is licensed under the GNU General Public License (GPL) v3.0.

This project is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

## Contact

For any questions or feedback, please contact the author:

- **Author:** devZiyad
- **GitHub:** [https://github.com/devZiyad](https://github.com/devZiyad)

## Disclaimer

This software is provided as-is without any warranties or guarantees. Use it at your own risk.
