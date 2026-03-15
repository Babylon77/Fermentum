# Fermentum Style Guide

## Design direction

Fermentum uses a cyberpunk mission-command interface.

The product should feel like a professional operations console:

- dark, layered surfaces
- sharp information hierarchy
- strong system-state signaling
- restrained glow accents
- dense but readable controls

The goal is not "gamer neon." The goal is disciplined tactical clarity.

## Visual principles

### 1. Command clarity

Every screen should immediately answer:

- what system am I looking at
- what state is it in
- what action matters next

### 2. High-density, low-chaos

Information-rich is good. Clutter is not.

Use:

- panels
- section headers
- metric clusters
- consistent spacing

Avoid:

- decorative gradients everywhere
- oversized cards
- excessive shadows
- uncontrolled glow

### 3. Surfaces over whitespace

Layouts should be built from intentional panels and command surfaces rather than floating content on empty backgrounds.

### 4. Touch and desktop parity

Every control must feel good with:

- thumb interaction
- mouse
- trackpad
- keyboard navigation

## Color system

### Core palette

- background base: deep graphite-blue
- panel surface: layered slate-teal
- panel elevated: cold steel blue
- primary accent: electric cyan
- secondary accent: hazard amber
- success: reactor green
- warning: signal amber
- error: alert red
- information: ion blue

### Usage rules

- Cyan is for active focus, selected states, charts, and primary actions.
- Amber is for brew timing, hot-side process emphasis, and caution.
- Green is for stable readings and completed states.
- Red is for destructive actions, dangerous states, and major faults.
- Avoid using more than one accent family heavily within the same component.

## Typography

### Tone

Typography should feel technical and intentional.

Use:

- a square or industrial display face for headings
- a clean, highly legible UI sans for body text and forms
- tabular numerals for brewing metrics and timers

### Hierarchy

- screen titles are compact and assertive
- section titles use all caps sparingly
- body text stays quiet and readable
- numeric outputs are larger and more prominent than descriptive labels

## Layout

### Grid

- 8-point spacing system
- panel-based composition
- desktop layouts can be multi-column
- mobile layouts should stack cleanly without losing context

### Panels

Panels are the core layout primitive.

Panels should have:

- subtle border contrast
- slightly lifted surface tone
- consistent internal padding
- optional top-edge accent strip for status grouping

## Component guidance

### Cards and panels

- prefer squared or lightly rounded corners
- use borders more than large shadows
- include headers when the content is operational
- reserve elevated panels for priority content

### Buttons

Primary button:

- solid cyan treatment
- high contrast label
- clear hover, pressed, and disabled states

Secondary button:

- tinted surface with border
- lower visual weight

Danger button:

- red accent only for destructive intent

### Inputs

- dark field surfaces
- visible border contrast at rest
- cyan focus ring
- labels above inputs
- helper text always available for important fields

### Tables and lists

- tables should feel like control-room data panes
- support zebra contrast or subtle row separators
- selected rows use cyan emphasis, not full-fill saturation

### Metrics

- key brew metrics should be grouped into compact tiles
- use tabular numerals
- attach status color only when meaningfully tied to state

### Charts

- dark chart background
- thin gridlines
- restrained color palette
- avoid rainbow series

## Motion

- short, deliberate transitions
- screen entry should feel like systems coming online
- status changes may pulse softly once
- avoid playful bounce or consumer-app animation language

## Content style

- plain, technical language
- concise labels
- action-oriented button text
- no cutesy copy
- tutorials should teach without becoming patronizing

## Brewing workflow cues

- hot-side operations can use amber emphasis
- fermentation and stable telemetry can use cyan and green
- packaging and warnings can use amber or red depending on risk
- AI help should be visually distinct from deterministic calculation outputs

## Non-negotiables

- no light theme in MVP
- no default mobile-first consumer-card aesthetic
- no random third-party component styling
- no inconsistent button shapes or field treatments
- no unlabeled status colors


