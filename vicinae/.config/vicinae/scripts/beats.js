#!/usr/bin/env bun
// @vicinae.schemaVersion 1
// @vicinae.title beats
// @vicinae.mode silent

import { $ } from "bun";

const STATIONS = [
  { name: "SomaFM IDM", url: "https://ice1.somafm.com/cliqhop-256-mp3" },
  { name: "SomaFM Vaporwaves", url: "https://ice1.somafm.com/vaporwaves-128-mp3" },
  { name: "SomaFM Groove Salad", url: "https://ice6.somafm.com/groovesalad-256-mp3" },
  { name: "SomaFM Metal Detector", url: "https://somafm.com/nossl/metal130.pls" },
  { name: "SomaFM Sonic Universe", url: "https://somafm.com/sonicuniverse256.pls" },
  { name: "SomaFM DEF CON", url: "https://somafm.com/defcon256.pls" },
  { name: "SomaFM Beat Blender", url: "https://somafm.com/beatblender130.pls" },
  { name: "Lofi Girl", url: "https://play.streamafrica.net/lofiradio" },
  { name: "Chillhop", url: "http://stream.zeno.fm/fyn8eh3h5f8uv" },
  { name: "Box Lofi", url: "http://stream.zeno.fm/f3wvbbqmdg8uv" },
  { name: "The Bootleg Boy", url: "http://stream.zeno.fm/0r0xa792kwzuv" },
  { name: "Radio Spinner", url: "https://live.radiospinner.com/lofi-hip-hop-64" },
  { name: "SmoothChill", url: "https://media-ssl.musicradio.com/SmoothChill" },
];

async function main() {
  try {
    try {
      const check = await $`pgrep -f "title=radio-mpv"`.quiet();
      if (check.exitCode === 0) {
        await $`pkill -f "title=radio-mpv"`.quiet();
        process.exit(0);
      }
    } catch (e) {
      // It's safe to ignore "not found" errors for pgrep
    }

    // Prepare and show menu
    const menuList = STATIONS.map((s, i) => `${i + 1}. ${s.name}`).join("\n");
    const choice = await $`echo ${menuList} | vicinae dmenu`.text();

    if (!choice.trim()) process.exit(0);

    // Parse selection
    const index = parseInt(choice.split(".")[0]) - 1;
    const station = STATIONS[index];

    if (station) {
      const msg = `${station.name} ☕️🎶`;
      await $`notify-send "Playing now: " ${msg} --icon=media-tape`;

      Bun.spawn(["mpv", "--volume=60", "--title=radio-mpv", station.url], {
        stdout: "ignore",
        stderr: "ignore",
        stdin: "ignore",
        onExit() {}
      }).unref();
    }

    process.exit(0);

  } catch (err) {
    console.error("Extension Error:", err);
    process.exit(1);
  }
}

main();
