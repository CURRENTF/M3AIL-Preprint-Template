# Source and adaptation notice

The LaTeX layout in this repository was adapted on 2026-09-01 from the public
ArXiv source package for:

> Haowei Zhang, Shudong Yang, Jinlan Fu, See-Kiong Ng, and Xipeng Qiu.
> "HERMES: KV Cache as Hierarchical Memory for Efficient Streaming Video
> Understanding." arXiv:2601.14724.

Adaptations made for this repository:

1. paper-specific text, figures, tables, macros, and appendix content were
   removed;
2. the class was renamed from `mosi.cls` to `m3ailpreprint.cls` and its metadata
   commands were generalized for reuse;
3. the abstract panel's cyan-to-blue gradient was replaced with a plain white
   background and a light outline;
4. the OpenMOSS header wordmark was replaced with the standalone graphic from
   the public M3AIL logo at <https://m3ail.github.io/images/logo.png>, followed
   by a compact typeset `M³AIL` label;
5. the M3AIL graphic itself was extracted as a high-resolution transparent PNG
   without embedded Chinese or English wordmark text.

This repository does not imply endorsement by the paper authors, OpenMOSS, or
M3AIL. Review the upstream source and asset terms before redistribution.
