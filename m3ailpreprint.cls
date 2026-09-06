\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{m3ailpreprint}[2026/09/02 M3AIL preprint template]

\PassOptionsToPackage{table}{xcolor}
\LoadClassWithOptions{article}

% Page and paragraph layout
\RequirePackage[
  letterpaper,
  top=2.75cm,
  bottom=2.5cm,
  left=2.5cm,
  right=2.5cm,
  columnsep=0.65cm
]{geometry}
\RequirePackage{setspace}
\setstretch{1.04}
\RequirePackage{parskip}
\RequirePackage[latin,english]{babel}
\RequirePackage{hyphenat}
\RequirePackage{placeins}

% Typography
\RequirePackage[T1]{fontenc}
\RequirePackage{amsthm,amsmath,amsfonts,amssymb}
\RequirePackage{newpxtext}
\RequirePackage[bigdelims,vvarbb]{newpxmath}
\RequirePackage[scaled=1.1]{zlmtt}
\RequirePackage[tracking=smallcaps]{microtype}
\RequirePackage{bm}

% Figures, tables, and title-box support
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage{booktabs}
\RequirePackage{nicematrix}
\RequirePackage{multirow}
\RequirePackage[most]{tcolorbox}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{needspace}

% Reserve enough room for the first-page mark without moving the text block.
\setlength{\headheight}{42pt}
\addtolength{\topmargin}{-30pt}

% M3AIL palette, inherited from the source paper's blue hierarchy.
\definecolor{mthreeblue}{HTML}{2E5AA8}
\newcommand{\mthreeblue}[1]{{\bfseries\color{mthreeblue}#1}}

% References
\RequirePackage[colorlinks]{hyperref}
\hypersetup{
  linkcolor=mthreeblue,
  citecolor=mthreeblue,
  urlcolor=mthreeblue
}
\RequirePackage[noabbrev,nameinlink]{cleveref}
\RequirePackage[numbers,sort&compress]{natbib}
\def\bibfont{\small}
\addto{\captionsenglish}{\renewcommand{\refname}{References}}

% Section and caption styles
\RequirePackage{titlesec}
\newcommand{\sectionfont}{\fontsize{12}{14}\selectfont}
\newcommand{\subsectionfont}{\fontsize{11}{13}\selectfont}
\titleformat*{\paragraph}{\itshape}
\titleformat*{\section}{\sectionfont\bfseries\color{mthreeblue}}
\titleformat*{\subsection}{\subsectionfont\bfseries\color{mthreeblue}}
\titleformat*{\subsubsection}{\normalsize\bfseries\color{mthreeblue}}

\RequirePackage{caption}
\DeclareCaptionLabelSeparator{mthreeempty}{}
\DeclareCaptionFormat{mthreecustom}{{\bfseries#1 #2} #3}
\captionsetup{
  singlelinecheck=true,
  format=mthreecustom,
  labelsep=mthreeempty,
  font=small
}
\captionsetup[sub]{
  singlelinecheck=true,
  format=mthreecustom,
  labelsep=mthreeempty,
  font=small
}

% Metadata collection
\newcommand{\titlefont}{\fontsize{18}{20}\selectfont}
\newcommand{\authorfont}{\fontsize{12}{14}\selectfont}
\newcommand{\affiliationfont}{\fontsize{10}{12}\selectfont}
\newcommand{\contributionfont}{\fontsize{10}{12}\selectfont}
\newcommand{\checkdatafont}{\fontsize{7.92}{10}\selectfont}
\newcommand{\abstractinfont}{\fontsize{10}{12}\selectfont}
\newcommand{\abstractheadingfont}{\fontsize{12}{14}\selectfont}

\newcommand{\titlelist}{}
\newcommand{\authorlist}{}
\newcommand{\affiliationlist}{}
\newcommand{\contributionlist}{}
\newcommand{\checkdatalist}{}
\newcommand{\abstractlist}{}

\renewcommand{\title}[1]{\gdef\titlelist{{\titlefont\bfseries#1}}}

\newcommand{\authorformat}[2][]{%
  {\authorfont\bfseries #2\ifstrempty{#1}{}{$^{#1}$}}%
}
\renewcommand{\author}[2][]{%
  \ifdefempty{\authorlist}{}{\gappto\authorlist{\hspace{0.7em}\allowbreak}}%
  \gappto\authorlist{\authorformat[#1]{#2}}%
}

\newcommand{\affiliationformat}[2][]{%
  {\affiliationfont\ifstrempty{#1}{}{$^{#1}$}#2}%
}
\newcommand{\affiliation}[2][]{%
  \ifdefempty{\affiliationlist}{}{\gappto\affiliationlist{\hspace{0.7em}\allowbreak}}%
  \gappto\affiliationlist{\affiliationformat[#1]{#2}}%
}

\newcommand{\contributionformat}[1]{{\contributionfont#1}}
\newcommand{\contribution}[1]{%
  \ifdefempty{\contributionlist}{}{\gappto\contributionlist{\hspace{0.7em}\allowbreak}}%
  \gappto\contributionlist{\contributionformat{#1}}%
}

\newcommand{\checkdataformat}[2][]{%
  {\small{\checkdatafont\bfseries#1:} #2}%
}
\newcommand{\checkdata}[2][]{%
  \ifdefempty{\checkdatalist}{}{\gappto\checkdatalist{\par}}%
  \gappto\checkdatalist{\checkdataformat[#1]{#2}}%
}

\renewcommand{\abstract}[1]{\gdef\abstractlist{{\abstractinfont#1}}}
\newcommand{\email}[1]{\href{mailto:#1}{\texttt{#1}}}
\renewcommand{\date}[1]{\checkdata[Date]{#1}}
\newcommand{\correspondence}[1]{\checkdata[Correspondence]{#1}}

% First-page brand marks. Both PNG files use transparent backgrounds.
\newcommand{\mthreewordmark}{%
  {\fontsize{15}{15}\selectfont\bfseries\color{mthreeblue}%
   M\textsuperscript{3}AIL}%
}

\fancypagestyle{firststyle}{%
  \fancyhf{}
  \fancyhead[L]{%
    \raisebox{-10mm}[0pt][0pt]{%
      \includegraphics[height=13mm]{assets/m3ail-mark.png}%
      \hspace{0.7mm}%
      \raisebox{4.2mm}{\mthreewordmark}}%
  }
  \fancyhead[R]{%
    \raisebox{-10mm}[0pt][0pt]{%
      \includegraphics[height=13mm]{assets/hit-mark.png}}%
  }
  \fancyfoot[C]{\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

\newcommand{\mthree@toptitlebar}{%
  {\color{mthreeblue}\hrule height 2.5pt}%
  \vskip 6mm
}
\newcommand{\mthree@bottomtitlebar}{%
  \vskip 5mm
  {\color{mthreeblue}\hrule height 1pt}%
}

\newcommand{\beginabstract}{%
  {\abstractheadingfont\mthreeblue{Abstract}\par}%
}

\newcommand{\mymaketitle}{%
  \begingroup
    \setlength{\parskip}{0mm}%
    \centering
    \nohyphens
    \mthree@toptitlebar
    \titlelist\par
    \mthree@bottomtitlebar
    \vskip 6mm
    \authorlist\par
    \vskip 3mm
    \affiliationlist\par
    \ifdefempty{\contributionlist}{}{%
      \vskip 3mm
      \contributionlist\par
    }%
  \endgroup
  \vskip 6mm

  % The source paper used a cyan-to-blue gradient here.  This extracted
  % template deliberately uses a plain white background instead.
  \begin{tcolorbox}[
    enhanced,
    arc=12pt,
    boxrule=0.5pt,
    colback=white,
    colframe=mthreeblue!22,
    left=15pt,
    right=15pt,
    top=20pt,
    bottom=15pt
  ]
    \setlength{\parindent}{0cm}%
    \setlength{\parskip}{0cm}%
    \begin{center}
      \beginabstract
      \vskip 3mm
    \end{center}
    \abstractlist\par
    \vskip 3mm
    {\setlength{\parskip}{0cm}%
      \ifdefempty{\checkdatalist}{\vspace*{0.65cm}}{\checkdatalist\par}}
  \end{tcolorbox}
  \FloatBarrier
  \thispagestyle{firststyle}
}

\if@twocolumn
  \renewcommand{\maketitle}{%
    \twocolumn[\vskip 3mm\mymaketitle\vskip 8mm]}
\else
  \renewcommand{\maketitle}{\mymaketitle\vskip 8mm}
\fi
