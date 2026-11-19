<p align="center"><img src=".github/dps-logo.svg" alt="DelPerroSands" width="360"></p>

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
| [dps-insurance](https://github.com/DaemonAlex/dps-insurance) | Ties m-Insurance into the MDT, impound, hospital and medical chart, and raises premiums for incidents other scripts report. Pairs with dps-medical and dps-fuel. |
| [dps-studio](https://github.com/DaemonAlex/dps-studio) | Build rooms, doors and portals in game from one panel (`/studio`), with owners and managers so staff do not have to support them. |
| [dps-shops](https://github.com/DaemonAlex/dps-shops) | Shop clerks who greet, react to robberies, talk back through dps-ainpcs and remember trouble, plus player-owned stores with delivery runs. Pairs with dps-ainpcs. |
| [dps-fleet](https://github.com/DaemonAlex/dps-fleet) | Vehicle browser and workshop on one panel: extras, liveries and mods for emergency vehicles. |
| [dps-parking](https://github.com/DaemonAlex/dps-parking) | Parking with valet, impound, violations and reserved spots. |
| [dps-vehiclepersistence](https://github.com/DaemonAlex/dps-vehiclepersistence) | Vehicles stay where they were parked. Pairs with dps-parking. |
| [dps-towjob](https://github.com/DaemonAlex/dps-towjob) | Queue-based tow job with jg-mechanic integration. |
| [dps-services](https://github.com/DaemonAlex/dps-services) | Request a tow and follow it live on the lb-phone and lb-tablet. Pairs with dps-towjob. |
| [dps-autoshops](https://github.com/DaemonAlex/dps-autoshops) | Self-service repair shops when no mechanic is on duty. |
| [dps-cityworker](https://github.com/DaemonAlex/dps-cityworker) | City infrastructure job and career. |
| [dps-ainpcs](https://github.com/DaemonAlex/dps-ainpcs) | NPCs you can talk to, with trust, quests and intel. Other scripts can make their own NPCs talk (dps-shops clerks). |
| [dps-badpeds](https://github.com/DaemonAlex/dps-badpeds) | Police interaction with NPCs: stops, arrests, intel and jail records. |
| [dps-gangwars](https://github.com/DaemonAlex/dps-gangwars) | Ambient gang NPCs, territory population and war reinforcements. |
| [dps-rotations](https://github.com/DaemonAlex/dps-rotations) | Moves dealers, harvests and other spots on a fixed schedule. |
| [dps-trains](https://github.com/DaemonAlex/dps-trains) | The train system. Pairs with dps-trains-stock, dps-traintools and dps-transitapp. |
| [dps-transitapp](https://github.com/DaemonAlex/dps-transitapp) | Live train arrival boards on the lb-phone. |
| [dps-faceplant](https://github.com/DaemonAlex/dps-faceplant) | City help, reports and staff tools on the lb-phone and lb-tablet. |
| [dps-chat](https://github.com/DaemonAlex/dps-chat) | A command box for voice-only servers. No chat feed. |
| [dps-filmmode](https://github.com/DaemonAlex/dps-filmmode) | One key hides every HUD layer and gives a smooth free camera for recording. |
| [dps-fuel](https://github.com/DaemonAlex/dps-fuel) | Gas station drive-offs for the ox_fuel nozzle: ripped hose, pump fire, station camera and a police call, by odds. Pairs with dps-insurance. |
| [dps-voice](https://github.com/DaemonAlex/dps-voice) | Spoken lines for NPCs, station announcements, dispatch and shops, from local voice models first. Pairs with dps-ainpcs. |
| [dps-bags](https://github.com/DaemonAlex/dps-bags) | Real bags for ox_inventory: the bag you carry shows on your character. |
| [dps-items](https://github.com/DaemonAlex/dps-items) | Item rules for ox_inventory: locked items, glovebox seats and an exploit watch. |
| [dps-furniture](https://github.com/DaemonAlex/dps-furniture) | Puts streamed furniture packs into the qs-housing furniture shop. |
| [dps-shellbrowser](https://github.com/DaemonAlex/dps-shellbrowser) | Staff tool to look at every qs-housing shell and set its door. |
| [dps-signs](https://github.com/DaemonAlex/dps-signs) | Rotates city messages across the SmartSigns road boards. |
| [dps-stationclear](https://github.com/DaemonAlex/dps-stationclear) | Hides map props that are in the way and keeps stray game peds off chosen spots. |
| [dps-citymap](https://github.com/DaemonAlex/dps-citymap) | A ready-made map of the whole city, cut into tiles for in-game screens. |
| [dps-cayo](https://github.com/DaemonAlex/dps-cayo) | Switches on the game's own Cayo Perico island, and nothing else. |
| [dps-aviation](https://github.com/DaemonAlex/dps-aviation) | Flight behaviour: aircraft idle instead of cutting out, sane taxi speed, a real start sequence. |
| [dps-airlines](https://github.com/DaemonAlex/dps-airlines) | Airlines job: passenger flights, cargo, charters, flight school and maintenance. |
| [dps-traintools](https://github.com/DaemonAlex/dps-traintools) | Rider tools for trains: board, sit, get off at a stop, ambient passengers. Pairs with dps-trains. |
| [dps-trains-stock](https://github.com/DaemonAlex/dps-trains-stock) | Train models and carriage sets for the train system. No scripts. Pairs with dps-trains. |
| [dps-traintracks](https://github.com/DaemonAlex/dps-traintracks) | Extra train track data. No scripts. Pairs with dps-trains. |
| [dps-crossings](https://github.com/DaemonAlex/dps-crossings) | Level crossings that close when a train comes. Pairs with dps-trains. |
| [dps-transit](https://github.com/DaemonAlex/dps-transit) | Passenger rail planning and scheduling (older system; dps-trains runs today). |
| [dps-maritime](https://github.com/DaemonAlex/dps-maritime) | Dock work and boat deliveries with progression. |
| [dps-maritime-maps](https://github.com/DaemonAlex/dps-maritime-maps) | Map files for the Jetsam docks, the map half of dps-maritime. |
| [dps-proracing](https://github.com/DaemonAlex/dps-proracing) | Circuit racing with lobbies, an AI practice grid and lap times. |
| [dps-carmenu](https://github.com/DaemonAlex/dps-carmenu) | Staff vehicle browser and spawner over the live Qbox vehicle list. |
| [dps-clothingbrowser](https://github.com/DaemonAlex/dps-clothingbrowser) | Staff tool to browse, identify and export clothing and uniforms. |
| [dps-lootpeds](https://github.com/DaemonAlex/dps-lootpeds) | Loot dead NPCs, with loot tables per model. |
| [dps-hookers](https://github.com/DaemonAlex/dps-hookers) | Adults-only RP (18+), adapted from MH Hookers by MaDHouSe. |
| [dps-weatherbridge](https://github.com/DaemonAlex/dps-weatherbridge) | Lets qb-weathersync and Renewed-Weathersync scripts work with night_natural_disasters. |
| [dps-bucketfix](https://github.com/DaemonAlex/dps-bucketfix) | Puts players back in the main world after spawning. |
| [dps-unfocus](https://github.com/DaemonAlex/dps-unfocus) | One key that frees a player stuck in a menu. |
| [dps-welcomecam](https://github.com/DaemonAlex/dps-welcomecam) | Aims the first camera a new player sees. |
| [dps-handlingdump](https://github.com/DaemonAlex/dps-handlingdump) | Developer tool: saves the stock handling of every vanilla vehicle. |
| [dps-weaponsounds](https://github.com/DaemonAlex/dps-weaponsounds) | Custom weapon sounds (planning; no code yet). |
| [dps-events](https://github.com/DaemonAlex/dps-events) | Playtime reward events (planning; no code yet). |
