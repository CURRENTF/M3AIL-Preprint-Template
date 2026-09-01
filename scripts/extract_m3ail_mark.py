#!/usr/bin/env python3
"""Extract the left-hand M3AIL mark from the public wordmark image.

The source image already has a transparent background.  We crop the icon,
preserve its exact silhouette, and upscale only the alpha mask so the output
stays a clean, flat-color logo without resampling halos.
"""

from __future__ import annotations

import argparse
from collections import Counter
from pathlib import Path

from PIL import Image


def extract_mark(source: Path, output: Path, size: int) -> None:
    image = Image.open(source).convert("RGBA")

    # The icon occupies the left third of the published horizontal wordmark.
    icon_region = image.crop((0, 0, round(image.width * 0.32), image.height))
    alpha = icon_region.getchannel("A")
    bbox = alpha.getbbox()
    if bbox is None:
        raise ValueError(f"No non-transparent pixels found in {source}")

    icon_region = icon_region.crop(bbox)
    alpha = icon_region.getchannel("A")

    pixels = icon_region.get_flattened_data()
    opaque_colors = [
        pixel[:3]
        for pixel in pixels
        if pixel[3] >= 240
    ]
    if not opaque_colors:
        raise ValueError(f"No opaque logo pixels found in {source}")
    mark_color = Counter(opaque_colors).most_common(1)[0][0]

    padding = round(size * 0.07)
    available = size - 2 * padding
    scale = min(available / icon_region.width, available / icon_region.height)
    resized_size = (
        max(1, round(icon_region.width * scale)),
        max(1, round(icon_region.height * scale)),
    )
    resized_alpha = alpha.resize(resized_size, Image.Resampling.LANCZOS)

    canvas = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    mark = Image.new("RGBA", resized_size, (*mark_color, 255))
    mark.putalpha(resized_alpha)
    position = ((size - resized_size[0]) // 2, (size - resized_size[1]) // 2)
    canvas.alpha_composite(mark, position)

    output.parent.mkdir(parents=True, exist_ok=True)
    canvas.save(output, optimize=True)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--size", type=int, default=2048)
    args = parser.parse_args()
    extract_mark(args.source, args.output, args.size)


if __name__ == "__main__":
    main()
