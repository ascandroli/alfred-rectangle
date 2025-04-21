# Rectangle Alfred Workflow

An extremely simple, minimal and fast Alfred workflow that lets you trigger [Rectangle](https://rectangleapp.com/) actions by name.

* **Search by action name:** Quickly access any Rectangle action via Alfred.
* **No shortcut simulation:** Relies on Rectangle’s URL scheme (rectangle://execute-action?name=...), not simulated keypresses.
  * Keyboard shortcuts are displayed only as a reference, not as the primary means of triggering actions. see [Configuration for Custom Shortcuts](#configuration-for-custom-shortcuts)
* **Shortcut-agnostic:** Works regardless of your Rectangle config (default, Spectacle, or custom).
* **Blazing fast:** Uses a static JSON list and a Alfred's Script Filter for instant results—no runtime config lookup.

For users, like me, who prefer names over hotkeys.

## Prerequisites

- [Alfred](https://www.alfredapp.com/) with Powerpack
- [Rectangle](https://rectangleapp.com/) window manager for macOS

## Installation

1. Download the workflow file
2. Double click to import it into Alfred
3. Alfred will automatically install the workflow

## Usage

1. In Alfred, type `r` followed by a space
2. Start typing any Rectangle action name (e.g., "left", "right", "center")
3. Select the desired action and press Enter to execute it

The default trigger keyword is `r`, but you can customize this to fit your preferences.


## Configuration for Custom Shortcuts

The workflow comes pre-configured with the default Rectangle shortcuts. If you have customized your Rectangle shortcuts and want to update the visual shortcut hints:

1. Export your Rectangle configuration to `RectangleConfig.json`
2. Run the included Swift package to convert your configuration into the Alfred Script Filter format:
   ```
   swift run
   ```
3. This will generate an updated JSON file that reflects your custom shortcuts

You only need to run this conversion process when you modify your Rectangle shortcuts. This approach prioritizes speed over real-time updates, making the workflow as fast as possible.

## ...
> Curious about the thinking behind this and other workflows? [Read my design principles.](https://github.com/ascandroli/alfred-workflows)
