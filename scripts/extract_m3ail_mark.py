#!/usr/bin/env python3
"""Extract the left-hand M3AIL mark from the public wordmark image.

The source image already has a transparent background.  We crop the icon,
preserve its silhouette, tighten any soft alpha fringe, and render it in the
template blue so the output stays crisp and visually consistent.
"""

from __future__ import annotations

import argparse
from pathlib import Path

from PIL import Image


DEFAULT_MARK_COLOR = (0x2E, 0x5A, 0xA8)


def parse_hex_color(value: str) -> tuple[int, int, int]:
    value = value.removeprefix("#")
    if len(value) != 6:
        raise argparse.ArgumentTypeError("color must be a six-digit RGB hex value")
    try:
        return tuple(int(value[index:index + 2], 16) for index in (0, 2, 4))
    except ValueError as exc:
        raise argparse.ArgumentTypeError("color must be a six-digit RGB hex value") from exc


def sharpen_alpha(alpha: Image.Image) -> Image.Image:
    """Compress the antialias transition while preserving the 50% contour."""

    return alpha.point(
        lambda value: (
            0
            if value <= 64
            else 255
            if value >= 191
            else round((value - 64) * 255 / 127)
        )
    )


def extract_mark(
    source: Path,
    output: Path,
    size: int,
    mark_color: tuple[int, int, int],
) -> None:
    image = Image.open(source).convert("RGBA")

    # The icon occupies the left third of the published horizontal wordmark.
    icon_region = image.crop((0, 0, round(image.width * 0.32), image.height))
    alpha = icon_region.getchannel("A")
    bbox = alpha.getbbox()
    if bbox is None:
        raise ValueError(f"No non-transparent pixels found in {source}")

    icon_region = icon_region.crop(bbox)
    alpha = sharpen_alpha(icon_region.getchannel("A"))

    padding = round(size * 0.07)
    available = size - 2 * padding
    scale = min(available / icon_region.width, available / icon_region.height)
    resized_size = (
        max(1, round(icon_region.width * scale)),
        max(1, round(icon_region.height * scale)),
    )
    resized_alpha = alpha.resize(resized_size, Image.Resampling.LANCZOS)
    resized_alpha = resized_alpha.point(
        lambda value: 0 if value <= 1 else 255 if value >= 254 else value
    )

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
    parser.add_argument(
        "--color",
        type=parse_hex_color,
        default=DEFAULT_MARK_COLOR,
        metavar="RRGGBB",
        help="flat mark color (default: 2E5AA8)",
    )
    args = parser.parse_args()
    extract_mark(args.source, args.output, args.size, args.color)


if __name__ == "__main__":
    main()
