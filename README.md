# dps-fixes

Small DelPerroSands fixes kept in one resource.

## What it is for

A busy server collects small problems. A menu sticks. A sign on a building says "coming soon".
Players land in the wrong instance after spawn. A new weather script breaks older scripts. Each
fix is a few lines, and one resource per fix makes a long, messy list. This resource holds them
all. Each fix is its own file.

## What it does

- **Unstick.** F10 or `/unstick` frees a stuck menu and unfreezes the player.
- **Esc guard.** While any menu has focus, Esc belongs to that menu and does not open the pause
  menu. The guard holds for half a second after the menu closes, so the same key press does not
  fall through to the game.
- **Casino sign.** Hides the "coming soon" sign on the Krystal Casino entrance.
- **Routing bucket fix.** Moves players left in routing bucket 1 back to bucket 0. It checks
  five seconds after spawn and character load, and sweeps every 15 seconds.
- **Weather bridge.** Makes night_natural_disasters answer the qb-weathersync events and fills
  `GlobalState.weather`. Players indoors get no rain and a held night hour.

## On its own, and with other scripts

**On its own.** Unstick and the Esc guard work with nothing else installed. The other fixes
each wait for the script they fix. If that script is missing, the fix does nothing and causes
no errors.

**With a paid spawn selector (wasabi_spawn).** That script puts players in routing bucket 1
while they pick a spawn and leaves them there. Players in bucket 1 cannot see trains, and the
entity lockdown that qbx_core sets on bucket 0 does not cover them. The fix moves them back.
It runs on the server and does not touch wasabi_spawn's files, so an update does not undo it.

**With a paid housing script (qs-housing).** Housing uses its own routing buckets for
interiors. Only bucket 1 is corrected. Players inside a house are left alone.

**With [dps-trains](https://github.com/DaemonAlex/dps-trains).** Trains only spawn for players
in bucket 0. With the bucket fix running, trains appear.

**With a paid casino map and script (nopixel-casino, rcore_casino).** The map shows a "coming
soon" sign over the entrance. The fix hides that one sign and puts it back if dps-fixes stops.
It hides the sign again if the map restarts. The way in and out is rcore_casino's own setting.
No casino file is edited.

**With a paid weather script (night_natural_disasters).** Scripts written for qb-weathersync or
Renewed keep working. Paid housing (qs-housing, qs-motorhome, qs-yacht, qs-motels-creator),
qbx_core character creation and
[dps-studio](https://github.com/DaemonAlex/dps-studio) rooms get dry, evenly lit interiors.
wasabi_police and [dps-ainpcs](https://github.com/DaemonAlex/dps-ainpcs) can read the weather
from `GlobalState.weather`. The bridge only calls the weather script's exports.

**With dps-unfocus and dps-weatherbridge.** Those are the older single-fix versions of the
unstick key and the weather bridge. dps-fixes replaces them. Do not run them beside it.

## Requirements

- None for unstick and the Esc guard.
- Each other fix needs the script it fixes: wasabi_spawn, nopixel-casino,
  night_natural_disasters.

## Install

1. Remove dps-unfocus, dps-weatherbridge, dps-bucketfix and dps-krystal-casino if you run them.
2. Put the folder in your resources and add `ensure dps-fixes`.
3. To add a new small fix, add a file under `client/` or `server/` and list it in
   `fxmanifest.lua`.

## Configuration

There is no config file. Each file holds its own values at the top.

| Item | Where | Meaning |
|---|---|---|
| `/unstick`, F10 | `client/unfocus.lua` | Free a stuck menu and unfreeze. Players can rebind the key. |
| `SIGN` | `client/krystal.lua` | Model, position and radius of the casino sign to hide. |
| `STUCK_BUCKET`, `TARGET_BUCKET` | `server/bucket.lua` | The bucket to correct (1) and where to move players (0). |
| `bucketcheck` | server console | Lists every player's routing bucket. |
| `ND` | `client/weather.lua`, `server/weather.lua` | Name of the weather resource. |
| `REFRESH_MS` | `server/weather.lua` | How often `GlobalState.weather` is refreshed. 30000 ms. |

## Recent changes

- **12 November 2026.** README added.
- **28 October 2026.** Four single-fix resources merged into this one: dps-unfocus,
  dps-krystal-casino, dps-bucketfix and dps-weatherbridge.
- **28 October 2026.** Esc guard added.
- **18 October 2026.** Weather bridge: the weather script is no longer paused indoors. The night
  is held for the player each frame, and a script can ask for its own hour.
- **30 September 2026.** Weather bridge: indoor players see night and no rain.

## Author

Made by [DaemonAlex](https://github.com/DaemonAlex) for DelPerroSands.

## Other DPS scripts

All of these are made for DelPerroSands and run together on one Qbox server. Each one works on
its own. The ones marked "pairs with" do more when both are running.

| Script | What it does |
|---|---|
| [dps-inventory](https://github.com/DaemonAlex/dps-inventory) | The inventory: ox_inventory with equipment slots, backpacks, armour plates and a self status panel, in the DelPerroSands colours. |
| [dps-medical](https://github.com/DaemonAlex/dps-medical) | Patient records, illness and diagnostic tests. A companion to wasabi_ambulance. Pairs with dps-inventory: symptoms and diagnoses show on the status panel. |
| [dps-insurance](https://github.com/DaemonAlex/dps-insurance) | Ties m-Insurance into the MDT, impound, hospital and medical chart. Pairs with dps-medical. |
| [dps-studio](https://github.com/DaemonAlex/dps-studio) | Build rooms, doors and portals in game from one panel (`/studio`), with owners and managers so staff do not have to support them. |
| [dps-shops](https://github.com/DaemonAlex/dps-shops) | Shop clerks who greet and react to a robbery, then player-owned shops. |
| [dps-fleet](https://github.com/DaemonAlex/dps-fleet) | Vehicle browser and workshop on one panel: extras, liveries and mods for emergency vehicles. |
| [dps-parking](https://github.com/DaemonAlex/dps-parking) | Parking with valet, impound, violations and reserved spots. |
| [dps-vehiclepersistence](https://github.com/DaemonAlex/dps-vehiclepersistence) | Vehicles stay where they were parked. Pairs with dps-parking. |
| [dps-towjob](https://github.com/DaemonAlex/dps-towjob) | Queue-based tow job with jg-mechanic integration. |
| [dps-services](https://github.com/DaemonAlex/dps-services) | Request a tow and follow it live on the lb-phone and lb-tablet. Pairs with dps-towjob. |
| [dps-autoshops](https://github.com/DaemonAlex/dps-autoshops) | Self-service repair shops when no mechanic is on duty. |
| [dps-cityworker](https://github.com/DaemonAlex/dps-cityworker) | City infrastructure job and career. |
| [dps-ainpcs](https://github.com/DaemonAlex/dps-ainpcs) | NPCs you can talk to, with trust, quests and intel. |
| [dps-badpeds](https://github.com/DaemonAlex/dps-badpeds) | Police interaction with NPCs: stops, arrests, intel and jail records. |
| [dps-gangwars](https://github.com/DaemonAlex/dps-gangwars) | Ambient gang NPCs, territory population and war reinforcements. |
| [dps-rotations](https://github.com/DaemonAlex/dps-rotations) | Moves dealers, harvests and other spots on a fixed schedule. |
| [dps-trains](https://github.com/DaemonAlex/dps-trains) | The train system. Pairs with dps-trains-stock, dps-traintools and dps-transitapp. |
| [dps-transitapp](https://github.com/DaemonAlex/dps-transitapp) | Live train arrival boards on the lb-phone. |
| [dps-faceplant](https://github.com/DaemonAlex/dps-faceplant) | City help, reports and staff tools on the lb-phone and lb-tablet. |
| [dps-chat](https://github.com/DaemonAlex/dps-chat) | A command box for voice-only servers. No chat feed. |
| [dps-filmmode](https://github.com/DaemonAlex/dps-filmmode) | One key hides every HUD layer and gives a smooth free camera for recording. |
