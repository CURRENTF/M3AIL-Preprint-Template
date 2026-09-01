# M3AIL Preprint Template

This repository contains a reusable LaTeX preprint style extracted from the
public ArXiv source of [HERMES: KV Cache as Hierarchical Memory for Efficient
Streaming Video Understanding](https://arxiv.org/abs/2601.14724).

The template preserves the source paper's page geometry, Palatino typography,
blue title and section hierarchy, author/affiliation block, abstract metadata,
and first-page header placement. Two requested branding changes are built in:

- the abstract panel has a plain white background, with no gradient;
- the OpenMOSS wordmark is replaced by the standalone M3AIL graphic mark plus
  a compact `M³AIL` label.

## Build

Run:

```bash
latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex
```

The compiled PDF is `main.pdf`. Clean intermediate LaTeX files with:

```bash
latexmk -C
```

## Customize

Edit the title-page metadata near the top of `main.tex`:

```tex
\title{Your Paper Title}
\author[1,*]{First Author}
\affiliation[1]{M$^3$AIL Research Group}
\abstract{Your abstract.}
\checkdata[Repository]{\url{https://github.com/your/project}}
```

The layout and reusable commands live in `m3ailpreprint.cls`. The header asset
is `assets/m3ail-mark.png`, a 2048-by-2048 RGBA PNG with a genuinely transparent
background and no embedded text. The adjacent `M³AIL` label is typeset by the
class through `\mthreewordmark`, so it remains sharp and editable.

## Regenerate the logo asset

The mark was extracted from the public M3AIL wordmark at
<https://m3ail.github.io/images/logo.png>. If the source image changes, install
Pillow and run:

```bash
python scripts/extract_m3ail_mark.py path/to/logo.png assets/m3ail-mark.png
```

The script preserves the published icon silhouette and outputs a transparent,
flat-color PNG. An ImageGen cleanup was also evaluated, but the deterministic
source extraction is used because it retains the original logo geometry more
faithfully at print size.

## Provenance

See `NOTICE.md` for source and adaptation notes. The extracted template is not
an official release of the HERMES authors, OpenMOSS, or M3AIL.
