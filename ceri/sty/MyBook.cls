% ----------------------
% "MyBook" LaTeX class
% v1.0 - 31/10/2022
%
% Alexis Pic
%
% Palettes provided from
% <https://coolors.co/>
%
% Compile with XeLaTeX
% ----------------------

% ----------------------
% INIT CLASS
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ceri/sty/MyBook}[31/10/2022 - v1.0]
\LoadClassWithOptions{book}                          % based on the article LaTeX class
% ----------------------

% ----------------------
% TITLE

\RequirePackage[dvipsnames,svgnames,x11names]{xcolor}
\RequirePackage[export]{adjustbox}
\RequirePackage{tikz}
\usetikzlibrary{shapes.geometric}
\usetikzlibrary{calc}

% \definecolor{bg}{HTML}{FFFFFF}
% \definecolor{fg}{HTML}{000000}

\makeatletter
\newcommand\MyTitle{
    % \thispagestyle{firststyle}
    \newlength\titleheight
    \settoheight{\titleheight}{\hbox{\begin{tikzpicture}\node[text width=15cm, align=left]{\fontsize{56}{70}\bfseries\selectfont\@title};\end{tikzpicture}}}
    \pagestyle{empty}
    \begin{titlepage}
        \begin{center}
            \begin{tikzpicture}[remember picture,overlay]
                \tikzset{shift=($(current page.north west)$)}
                \node[anchor=north west, inner sep=0pt] at ($(current page.north west)$) {
                    \adjincludegraphics[width=\paperwidth, page=1, decodearray={0 .5 0 .5 0 .5}, clip=true]{\titlepicture}
                };
                \node[
                    anchor=south west, fill=coro,
                    inner sep=0pt, draw=coro,
                    minimum height = 1.25\titleheight,
                    minimum width = \paperwidth, opacity=.5
                ] (r) at (0cm,\dimexpr-23.76cm-.1\titleheight) {};
                \node[
                    anchor=south east, fill=fg,
                    inner sep=0pt, draw=fg,
                    minimum height = 1.05\titleheight,
                    minimum width = .5cm
                ] (r) at (1cm,-23.76cm) {};
                \node[
                    anchor=south west,
                    inner sep=.3cm, text=bg,
                    text width=15cm,
                    minimum height = 1.05\titleheight,
                    minimum width = 10cm
                ] (r) at (1cm,-23.76cm) {\fontsize{56}{70}\bfseries\selectfont\@title};
                \node[
                    anchor=south,
                    inner sep=0pt, text=bg,
                    text width=15cm,
                    minimum width = 10cm,
                    align=center
                ] (r) at (10.5cm,-27cm) {\fontsize{35}{70}\itshape\selectfont\subtitle};
                \node[
                    anchor=north,
                    inner sep=.5cm, text=bg,
                    text width=19cm,
                    minimum width = 10cm,
                    align=center
                ] (r) at (10.5cm,-1.5cm) {\fontsize{20}{32}\bfseries\selectfont\@author};
            \end{tikzpicture}
        \end{center}
    \end{titlepage}
    \newpage~
    \pagestyle{empty}
    \newpage~
    \cleardoublepage
    \pagestyle{fancy}
}

\makeatother

\newcommand{\MyChapter}{
    \newlength\imageheight
    \settoheight{\imageheight}{\includegraphics{\chappicture}}
    \thispagestyle{chappage}
    \begin{tikzpicture}[remember picture,overlay]
        \tikzset{shift=($(current page.north west)$)}
        \node[anchor=north west, inner sep=0pt] at ($(current page.north west)$) {
            \adjincludegraphics[width=.8\paperwidth, page=1, trim={0 {.193\imageheight} 0 {.193\imageheight}}, clip=true]{\chappicture}
        };
        \node[
            anchor=north west,
            inner sep=0pt, draw=fg,
            fill=fg, text=bg,
            minimum height = 5.8cm,
            minimum width = .195\paperwidth
        ] (r) at (16.9cm,0) {\fontsize{40}{48}\bfseries\selectfont\thechapter};%\dunderline[-6pt]{3pt}{\titlenumber}};
    \end{tikzpicture}
    % \setcounter{section}{0}
    \pagestyle{fancy}
    \let\imageheight\relax
}

\renewcommand\maketitle\MyTitle
\let\titletemp\title
\renewcommand{\title}[3][]{
    \def\titlepicture{#3} % Dummy command to keep in memory the image path
    \def\subtitle{#1}
    \titletemp{#2}
} % Title has now 2 arguments

\let\chaptemp\chapter
\renewcommand{\chapter}[3][]{
    \def\chappicture{#3}
    \chaptemp[#1]{#2}
    \setcounter{section}{0}
    \let\imageheight\relax
}
% ----------------------

% ----------------------
% INIT FONTS
\RequirePackage[french]{babel}
\RequirePackage[no-math]{fontspec} % 'no-math' for the rendering issue
\RequirePackage{mathtools}
% \RequirePackage[notext,not1]{stix2} % init. custom math font

\setsansfont{KarasumaGothic}[                       % set up custom font
    Extension = .otf,
    Path = ceri/fonts/KarasumaGothic/,
    UprightFont = *-Regular,
    BoldFont = *-Bold,
    ItalicFont = *-Italic,
    BoldItalicFont = *-BoldItalic
]
\renewcommand{\familydefault}{\sfdefault}   % use the sans-serif font
% ----------------------

% ----------------------
% INIT PAPER
\RequirePackage[top=2.5cm,
    bottom=2.5cm,
    left=2.5cm,
    right=2.5cm]{geometry}

\RequirePackage[french]{varioref}           % improves cross-refs
% ----------------------

% ----------------------
% INIT MATH
\RequirePackage{amssymb, amsmath}

% \RequirePackage{cancel}
%
\RequirePackage{unicode-math} % Init. math font
\unimathsetup{mathrm=sym}
\setmathfont{STIX Two Math}
\setmathfont[range={\mathcal,\mathbfcal},StylisticSet=1]{STIX Two Math}
\setmathfont[range={\mathscr},StylisticSet=1]{STIX Two Math}
\setmathfont[range={\mathbb}]{Cambria Math} % Font changed for the "BlackBoard" math
\setmathfont[range={up/num}, Path = ceri/fonts/KarasumaGothic/]{KarasumaGothic-Regular.otf}
\setmathfont[range={bfup/num}, Path = ceri/fonts/KarasumaGothic/]{KarasumaGothic-Bold.otf}
% \setmathfont[range={bfup/num}]{ceri/fonts/KarasumaGothic/KarasumaGothic-Bold.otf}
\let\mathbf\symbf

\makeatletter
\count@=`A \advance\count@\m@ne
\@whilenum\count@<`Z\do{%
    \advance\count@\@ne
    \begingroup\uccode`a=\count@
    \uppercase
    {\endgroup\DeclareMathSymbol{a}}
    {\mathalpha}
    {operators}
    {\count@}
}
\makeatother % Makes Capital letters in Roman as default in formulas

\newcommand{\mi}[1]{\mathnormal{#1}} % Renders in italic letters (roman is default for capitals)
% ----------------------

% ----------------------
% FOOTNOTES AND ITEMIZING
\RequirePackage{enumitem}

\AddThinSpaceBeforeFootnotes
\FrenchFootnotes
\RequirePackage{footnotebackref} % For clickable footnotes
\renewcommand{\thefootnote}{(\arabic{footnote})} % Using brackets for footnotes
% ----------------------

% ----------------------
% GET CHAPTER NAMES
\renewcommand{\chaptermark}[1]{\markboth{\textnormal{\chaptername\ \thechapter.\ #1}}{}}
\renewcommand{\sectionmark}[1]{%
    \markright{#1}{}}
% ----------------------

% ----------------------
% HEADER/FOOTER SETTINGS

\RequirePackage{fancyhdr}

\makeatletter
\newcommand\FooterE{% fg, fg2, th, defini, rema, coro
    \begin{tikzpicture}[remember picture,overlay, shift=(current page.north west)]
        \begin{scope}[x={(current page.north east)},y={(current page.south west)}]
            \draw[draw = fg,     line width=0.5cm] ([yshift=0.25cm]0,1) -- ([yshift=0.25cm].5,1);
            \draw[draw = fg2,    line width=0.5cm] ([yshift=0.25cm]0.5,1) -- ([yshift=0.25cm].75,1);
            \draw[draw = th,     line width=0.5cm] ([yshift=0.25cm]0.75,1) -- ([yshift=0.25cm].875,1);
            \draw[draw = defini, line width=0.5cm] ([yshift=0.25cm]0.875,1) -- ([yshift=0.25cm].9375,1);
            \draw[draw = rema,   line width=0.5cm] ([yshift=0.25cm].9375,1) -- ([yshift=0.25cm].96875,1);
            \draw[draw = coro,   line width=0.5cm] ([yshift=0.25cm].96875,1) -- ([yshift=0.25cm]1,1);
            \node[anchor = south west, align = left] (r) at ([xshift=2.5cm, yshift=0cm]0,1) {\selectfont\scriptsize\color{bg}\bfseries{\subtitle}};
            \node[anchor = south east, align = right] (r) at ([xshift=-2.7cm, yshift=0cm]1,1) {\selectfont\scriptsize\color{bg}\bfseries{© \the\year\ - A. Pic}};
        \end{scope}
    \end{tikzpicture}%
}

\newcommand\FooterO{% fg, fg2, th, defini, rema, coro
    \begin{tikzpicture}[remember picture,overlay, shift=(current page.north west)]
        \begin{scope}[x={(current page.north east)},y={(current page.south west)}]
            \draw[draw = coro,     line width=0.5cm] ([yshift=0.25cm]0,1) -- ([yshift=0.25cm].03125,1);
            \draw[draw = rema,    line width=0.5cm] ([yshift=0.25cm]0.03125,1) -- ([yshift=0.25cm].0625,1);
            \draw[draw = defini,     line width=0.5cm] ([yshift=0.25cm]0.0625,1) -- ([yshift=0.25cm].125,1);
            \draw[draw = th, line width=0.5cm] ([yshift=0.25cm]0.125,1) -- ([yshift=0.25cm].25,1);
            \draw[draw = fg2,   line width=0.5cm] ([yshift=0.25cm].25,1) -- ([yshift=0.25cm].5,1);
            \draw[draw = fg,   line width=0.5cm] ([yshift=0.25cm].5,1) -- ([yshift=0.25cm]1,1);
            \node[anchor = south west, align = left] (r) at ([xshift=2.7cm, yshift=0cm]0,1) {\selectfont\scriptsize\color{bg}\bfseries{© \the\year\ - A. Pic}};
            \node[anchor = south east, align = right] (r) at ([xshift=-2.5cm, yshift=0cm]1,1) {\selectfont\scriptsize\color{bg}\bfseries{\subtitle}};
        \end{scope}
    \end{tikzpicture}%
}

\makeatother

\fancyhead[RE,LO]{\selectfont\Large{\color{fgText}Page \thepage}\vspace{.1cm}}
\makeatletter
\fancyhead[LE]{\selectfont\Large\bfseries{\color{fgText}\@title.}\vspace{.1cm}}
\makeatother
\fancyhead[RO]{\selectfont\Large\bfseries{\color{fgText}\nouppercase{\thechapter{}.\rightmark.}}\vspace{.1cm}}
\fancyfoot[CE]{\FooterE}
\fancyfoot[CO]{\FooterO}

\fancypagestyle{chappage} % for the first page only
{
    \fancyfoot[CE]{\FooterE}
    \fancyfoot[CO]{\FooterO}
    \fancyhf[h]{}
    \renewcommand{\headrulewidth}{0pt} % removes horizontal header line
}

\fancypagestyle{preface} % for the first page only
{
    \fancyfoot[CE]{\FooterE}
    \fancyfoot[CO]{\FooterO}
    \fancyhf[rh]{\selectfont\Large{\color{fgText}\thepage}\vspace{.1cm}}
    \fancyhf[lh]{\selectfont\Large\bfseries{\sectionmark{}}\vspace{.1cm}}
}
% ----------------------

% ----------------------
% CUSTOM SECTION HEADERS
\RequirePackage{titlesec}

\renewcommand{\thechapter}{\arabic{chapter}}
\renewcommand{\thesection}{\arabic{chapter}.\Roman{section}}
\renewcommand{\thesubsection}{\arabic{section}.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\arabic{section}.\arabic{subsection}.\arabic{subsection}}

\titleformat{\chapter}
{\vspace{2cm}\color{fgText}\fontsize{30}{35}\bfseries\selectfont}
{}
{-.8cm}
{\MyChapter}

\titleformat{\section}
{\color{fg}\normalfont\Large\bfseries}
{\thechapter.\thesection}
{1em}
{}

\titleformat{\subsection}
{\color{fg}\normalfont\large\bfseries}
{\thesubsection}
{1em}
{}

\titleformat{\subsubsection}
{\color{fg}\normalfont\normalsize\bfseries}
{\thesubsubsection}
{1em}
{}
% ----------------------

% ----------------------
% CODE ENVIRONMENT
\RequirePackage{minted}
\usemintedstyle{monokai}

\definecolor{bgcode}{HTML}{282828}

\newenvironment{python}{\VerbatimEnvironment\begin{minted}[
    linenos,
    mathescape,
    bgcolor = bgcode,
    frame=lines,
    framesep=2mm
]{python}}{\end{minted}}
\newenvironment{cpp}{\VerbatimEnvironment\begin{minted}[
    linenos,
    mathescape,
    bgcolor = bgcode,
    frame=lines,
    framesep=2mm
]{cpp}}{\end{minted}}
% ----------------------

% ----------------------
% THEOREM BOXES
\RequirePackage{amsthm}
\RequirePackage[framemethod=default]{mdframed}
\RequirePackage[noabbrev,nameinlink,french]{cleveref}

\newcommand\DefaultFrame[6]{
    % args : name, color, rightline, leftline, topline, bottomline
    \newmdenv[
        skipabove=5pt,
        skipbelow=5pt,
        rightline=#3,
        leftline=#4,
        topline=#5,
        bottomline=#6,
        linecolor=#2,
        backgroundcolor=bg,
        innerleftmargin=5pt,
        innerrightmargin=5pt,
        innertopmargin=-3pt,
        leftmargin=0cm,
        rightmargin=0cm,
        linewidth=1.25pt,
        innerbottommargin=5pt
    ]{#1Box}
}
\newcommand\DefaultFrameStar[6]{
    % args : name, color, rightline, leftline, topline, bottomline
    \newmdenv[
        skipabove=5pt,
        skipbelow=5pt,
        rightline=#3,
        leftline=#4,
        topline=#5,
        bottomline=#6,
        linecolor=#2,
        backgroundcolor=bg,
        innerleftmargin=5pt,
        innerrightmargin=5pt,
        innertopmargin=-3pt,
        leftmargin=0cm,
        rightmargin=0cm,
        linewidth=1.25pt,
        innerbottommargin=5pt
    ]{#1Box*}
}
\newcommand\DefaultFrameMult[6]{
    % args : name, color, rightline, leftline, topline, bottomline
    \newmdenv[
        skipabove=5pt,
        skipbelow=5pt,
        rightline=#3,
        leftline=#4,
        topline=#5,
        bottomline=#6,
        linecolor=#2,
        backgroundcolor=bg,
        innerleftmargin=5pt,
        innerrightmargin=5pt,
        innertopmargin=-3pt,
        leftmargin=0cm,
        rightmargin=0cm,
        linewidth=1.25pt,
        innerbottommargin=5pt
    ]{#1Boxs}
}

\newtheoremstyle{lemme}{3pt}{3pt}{\itshape}{}{\itshape}{.}{.5em}{}
\newtheorem{dummy}{}[section]
\renewcommand{\thedummy}{\arabic{chapter}.\arabic{section}.\arabic{dummy}}

\newcommand{\MakeThEnv}[8]{
    % args : env-name, title, style, color, rightline, leftline, topline, bottomline

    \DefaultFrame{#1}{#4}{#5}{#6}{#7}{#8}

    \theoremstyle{#3}
    \newtheorem{#1T}[dummy]{#2}

    \newenvironment{#1}{\begin{#1Box}\begin{#1T}}{\end{#1T}\end{#1Box}}

    \Crefname{#1T}{#2}{#2s}
    \crefname{#1T}{\lowercase{#2}}{\lowercase{#2s}}
}% makes theorem-style environments (numbered)
\newcommand{\MakeThEnvStar}[8]{
    % args : env-name, title, style, color, rightline, leftline, topline, bottomline

    \DefaultFrameStar{#1}{#4}{#5}{#6}{#7}{#8}

    \theoremstyle{#3}
    \newtheorem*{#1T*}{#2}

    \newenvironment{#1*}{\begin{#1Box*}\begin{#1T*}}{\end{#1T*}\end{#1Box*}}
}% makes theorem-style environments (non-numbered)

\newcommand{\MakeMultEnv}[9]{
    % args : env-name, title, style, color, rightline, leftline, topline, bottomline, item-label

    \DefaultFrameMult{#1}{#4}{#5}{#6}{#7}{#8}

    \theoremstyle{#3}
    \newtheorem*{#1Ts}{#2}

    \newenvironment{#1}{\begin{#1Boxs}\begin{#1Ts}\hfill\begin{enumerate}[%wide,
                label={#9}]}{\end{enumerate}\end{#1Ts}\end{#1Boxs}}
}% makes theorem-style environments (itemized)

\newcommand{\MakeDmEnv}[1]{
    \DefaultFrame{demo}{#1}{false}{false}{false}{false}
    \newenvironment{demo}{\begin{demoBox}\begin{proof}}{\end{proof}\end{demoBox}}
}% makes proof environment
% ----------------------

% ----------------------
% HOLES-IN-TEXT MAKER
\RequirePackage{multido}
\RequirePackage{setspace}

% modified version of https://www.developpez.net/forums/d1524021/autres-langages/autres-langages/latex/programmation-tex-avancee/textes-trou/
\makeatletter
\newif\if@prof % Boolean for changing mode (teacher or student)
    \@proffalse    % "Student" by default.

    \newlength\wordlength
    \newcounter{lines}

    % Mode switchers
    \def\ToEleve{\@proffalse}
    \def\ToProf{\@proftrue}

    \let\Dotfill\dotfill
    \def\dotfill#1{\cleaders\hbox to #1{.}\hfill}
    \newcommand\dotline[2][.5em]{\leavevmode\hbox to #2{\dotfill{#1}\hfil}}

    % Replace a word by a dotted blank.
    \def\Trouer#1{%
    \if@prof{#1}%                % If it is the "Teacher" mode, then the hidden word is displayed.
\else
    \settowidth\wordlength{#1}   % Take the length of the word
    \addtolength\wordlength{2em} % Add 2em to the length
    \dotline{\wordlength}  % Otherwise we display a dotted line.
\fi
}

% Replace a line by a dotted blank.
\newcommand\TrouerL[2][1]{%
    \setcounter{lines}{#1}
    \if@prof {#2}%                                                                      % If it is the "Teacher" mode, then the hidden line is displayed.
    \else
        \doublespacing
        \ifnum\value{lines}>1                                                          % Otherwise we display dotted lines.
            \addtocounter{lines}{-1}
            \Dotfill\endgraf
            \multido{}{\value{lines}}{\noindent\makebox[\textwidth]{\Dotfill}\endgraf}
        \else \Dotfill                                                                 % Case of a single line.
        \fi
        \singlespacing
    \fi
}

% Replace a word by a dotted blank.
\def\Blanc#1{%
    \if@prof{#1}%                % If it is the "Teacher" mode, then the hidden word is displayed.
    \else
    \settowidth\wordlength{#1}   % Take the length of the word
    \addtolength\wordlength{2em} % Add 2em to the length
    \rule{\wordlength}{0pt}  % Otherwise we display a dotted line.
    \fi
}

% Replace a line by a blank.
\newcommand\BlancL[2][1]{%
    \setcounter{lines}{#1}
    \if@prof {#2}%                                                                      % If it is the "Teacher" mode, then the hidden line is displayed.
    \else
        \ifnum\value{lines}>1                                                          % Otherwise we display dotted lines.
            \addtocounter{lines}{-1}
            \hfill\endgraf
            \multido{}{\value{lines}}{\noindent\makebox[\textwidth]{\hfill}\endgraf}
        \else \hfill                                                                 % Case of a single line.
        \fi
    \fi
}

\makeatother

% ---------------------- OPTIONS ----------------------
% ----------------------
% COLOR OPTIONS
\newcommand\ColorSetup[6]{
    \definecolor{fg}{HTML}{#1}			       % headers and hyperlinks
    \definecolor{fgText}{HTML}{000000}                % Text
    \definecolor{bg}{HTML}{FFFFFF}                 % Background
    \definecolor{fg2}{HTML}{#2}
    \definecolor{th}{HTML}{#3}
    \definecolor{defini}{HTML}{#4}
    \definecolor{rema}{HTML}{#5}
    \definecolor{coro}{HTML}{#6}

    %\definecolor{codecom}{HTML}{#8}
    %\definecolor{codebg}{HTML}{#9}
    %\definecolor{codekey}{HTML}{#10}
    %\definecolor{codestr}{HTML}{#11}
    %\definecolor{codenum}{HTML}{222222}

    % Syntax : \MakeThEnv{env-name}{title}{style}{color}{rightline}{leftline}{topline}{bottomline}
    %          \MakeThEnvStar{env-name}{title}{style}{color}{rightline}{leftline}{topline}{bottomline}
    %          \MakeMultEnv{env-name}{title}{style}{color}{rightline}{leftline}{topline}{bottomline}{item-label}

    \MakeThEnv{theo}{Théorème}{plain}{th}{false}{true}{false}{true}
    \MakeThEnvStar{theo}{Théorème}{plain}{th}{false}{true}{false}{true}

    \MakeThEnv{propo}{Proposition}{plain}{fg2}{true}{false}{false}{true}
    \MakeThEnvStar{propo}{Proposition}{plain}{fg2}{true}{false}{false}{true}

    \MakeThEnv{defin}{Définition}{definition}{defini}{false}{true}{false}{true}
    \MakeThEnvStar{defin}{Définition}{definition}{defini}{false}{true}{false}{true}

    \MakeThEnv{rem}{Remarque}{remark}{rema}{false}{true}{false}{false}
    \MakeThEnvStar{rem}{Remarque}{remark}{rema}{false}{true}{false}{false}
    \MakeMultEnv{rems}{Remarques}{remark}{rema}{false}{true}{false}{false}{\textbf{\arabic*.}}

    \MakeThEnv{prop}{Propriété}{plain}{th}{false}{true}{false}{false}
    \MakeThEnvStar{prop}{Propriété}{plain}{th}{false}{true}{false}{false}
    \MakeMultEnv{props}{Propriétés}{plain}{th}{false}{true}{false}{false}{\textbf{(\roman*)}}

    \MakeThEnv{lem}{Lemme}{lemme}{fg2}{false}{true}{false}{false}
    \MakeThEnvStar{lem}{Lemme}{lemme}{fg2}{false}{true}{false}{false}

    \MakeThEnv{coro}{Corollaire}{definition}{coro}{false}{true}{false}{false}
    \MakeThEnvStar{coro}{Corollaire}{definition}{coro}{false}{true}{false}{false}

    \MakeThEnv{ex}{Exemple}{definition}{bg}{false}{false}{false}{false}
    \MakeThEnvStar{ex}{Exemple}{definition}{coro}{false}{false}{false}{false}
    \MakeMultEnv{exs}{Exemples}{definition}{coro}{false}{false}{false}{false}{\textbf{\arabic*.}}

    \MakeThEnv{exo}{Exercice}{definition}{rema}{false}{true}{false}{false}
    \MakeThEnvStar{exo}{Exercice}{definition}{rema}{false}{true}{false}{false}
    \MakeMultEnv{exos}{Exercices}{definition}{rema}{false}{true}{false}{false}{\textbf{\arabic*.}}

    \MakeThEnv{meth}{Méthode}{definition}{fg}{false}{true}{true}{false}
    \MakeThEnvStar{meth}{Méthode}{definition}{fg}{false}{true}{true}{false}
    \MakeMultEnv{meths}{Méthodes}{definition}{fg}{false}{true}{true}{false}{\textbf{\arabic*.}}

    \MakeThEnv{axiom}{Axiome}{definition}{defini}{false}{true}{false}{false}
    \MakeThEnvStar{axioms}{Axiomes}{definition}{defini}{false}{true}{false}{false}

    \MakeThEnv{notat}{Notation}{definition}{defini}{false}{false}{false}{false}
    \MakeThEnvStar{notats}{Notations}{definition}{defini}{false}{false}{false}{false}

    \MakeDmEnv{bg}
    \newenvironment{rep}{\begin{demo}[Réponse]}{\end{demo}}
    \newenvironment{reps}{\begin{demo}[Réponses]}{\end{demo}}
}

% Option commands in "options.sty" file

\input{ceri/sty/options.sty}
% ----------------------

% ----------------------
% FINISH
% \ExecuteOptions{bluehoney} % Default color palette
\ProcessOptions\relax
% ----------------------
