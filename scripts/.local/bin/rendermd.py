#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "rich"
# ]
# ///

import sys

from rich.console import Console
from rich.live import Live
from rich.markdown import Markdown

def main():
    console = Console()
    md = ""
    with Live(Markdown(""), console=console, refresh_per_second=10) as live:
        while True:
            chunk = sys.stdin.read(1)
            if not chunk:
                break
            md += chunk
            live.update(Markdown(md))

if __name__ == "__main__":
    main()
