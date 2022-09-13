% ----------------------
% "MyCourse" LaTeX class
% v1.0 - 28/07/2022
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
\ProvidesClass{../MyCourse/ceri/sty/MyCourse}[02/08/2022 - v1.0]
\LoadClassWithOptions{article}                          % based on the article LaTeX class
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

\newcommand\dunderline[3][-1pt]{{%
  \sbox0{#3}%
  \ooalign{
    \copy0\cr\rule[\dimexpr#1-#2\relax]{\wd0}{#2}
}}}

\makeatletter
\newcommand\MyTitle{
    \thispagestyle{firststyle}
    \newlength\imageheight
    \settoheight{\imageheight}{\includegraphics{\titlepicture}}
    \begin{center}
        \begin{tikzpicture}[remember picture,overlay]
            \tikzset{shift=($(current page.north west)$)}
            \node[anchor=north west, inner sep=0pt] at ($(current page.north west)$) {
                \adjincludegraphics[width=.8\paperwidth, page=1, trim={0 {.193\imageheight} 0 {.193\imageheight}}, clip=true]{\titlepicture}
             };
            \node[
                anchor=north west,
                inner sep=0pt, draw=fg,
                fill=fg, text=bg,
                minimum height = 5.8cm,
                minimum width = .195\paperwidth
            ] (r) at (16.9cm,0) {\fontsize{40}{48}\bfseries\selectfont\titlenumber};%\dunderline[-6pt]{3pt}{\titlenumber}};
        \end{tikzpicture}
    \end{center}
    \vspace{3.5cm}
    {\fontsize{30}{35}\selectfont\bfseries\@title}
    \vspace{.5cm}
    \pagestyle{fancy}
}
\makeatother

\renewcommand\maketitle\MyTitle
\let\titletemp\title
\renewcommand{\title}[3]{
    \def\titlepicture{#1} % Dummy command to keep in memory the image path
    \def\titlenumber{#2}  % Dummy command to keep in memory the chapter number
    \titletemp{#3}
} % Title has now 3 arguments
\newcommand{\setclass}[1]{
    \def\theclass{#1} % Dummy command to keep in memory the class
}
\newcommand{\settheme}[1]{
    \def\thetheme{#1} % Dummy command to keep in memory the course theme
}
% ----------------------

% ----------------------
% INIT FONTS
\RequirePackage[french]{babel}
\RequirePackage[no-math]{fontspec} % 'no-math' for the rendering issue
\RequirePackage{mathtools}
% \RequirePackage[notext,not1]{stix2} % init. custom math font

\setsansfont{Inter}[                       % set up custom font
    Extension = .ttf,
    Path = ../MyCourse/ceri/fonts/Inter-Sans/,
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
\RequirePackage{cancel}
\RequirePackage{amssymb, amsmath}

\RequirePackage{unicode-math} % Init. math font

\setmathfont[]{STIX Two Math}
\setmathfont[range={\mathbb}]{Cambria Math} % Font changed for the "BlackBoard" math
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
% HEADER/FOOTER SETTINGS

\RequirePackage{fancyhdr}

\makeatletter
\newcommand\Footer{% fg, fg2, th, defini, rema, coro
    \begin{tikzpicture}[remember picture,overlay, shift=(current page.north west)]
        \begin{scope}[x={(current page.north east)},y={(current page.south west)}]
            \draw[draw = fg,     line width=0.5cm] ([yshift=0.25cm]0,1) -- ([yshift=0.25cm].5,1);
            \draw[draw = fg2,    line width=0.5cm] ([yshift=0.25cm]0.5,1) -- ([yshift=0.25cm].75,1);
            \draw[draw = th,     line width=0.5cm] ([yshift=0.25cm]0.75,1) -- ([yshift=0.25cm].875,1);
            \draw[draw = defini, line width=0.5cm] ([yshift=0.25cm]0.875,1) -- ([yshift=0.25cm].9375,1);
            \draw[draw = rema,   line width=0.5cm] ([yshift=0.25cm].9375,1) -- ([yshift=0.25cm].96875,1);
            \draw[draw = coro,   line width=0.5cm] ([yshift=0.25cm].96875,1) -- ([yshift=0.25cm]1,1);
            \node[anchor = west, align = left] (r) at ([xshift=2.5cm, yshift=0.25cm]0,1) {\selectfont\scriptsize\color{bg}\bfseries{\thetheme\ - \theclass}};
            \node[anchor = south east, align = right] (r) at ([xshift=-2.75cm, yshift=0cm]1,1) {\selectfont\scriptsize\color{bg}\bfseries{© \@date\ - \@author}};
        \end{scope}
    \end{tikzpicture}%
}

\fancyhf[lh]{\selectfont\Large\bfseries{\color{fgText}Chapitre \titlenumber. \@title}\vspace{.1cm}}
\makeatother

\fancyhf[rh]{\selectfont\Large{\color{fgText}Page \thepage}\vspace{.1cm}}
\fancyhf[cf]{\Footer}

\fancypagestyle{firststyle} % for the first page only
{
   \fancyhf[cf]{\Footer}
   \renewcommand{\headrulewidth}{0pt} % removes horizontal header line
}
% ----------------------

% ----------------------
% CUSTOM SECTION HEADERS
\RequirePackage{titlesec}

\titleformat{\section}
    {\color{fg}\normalfont\Large\bfseries}
    {\thesection}
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

\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thesubsection}{\Roman{section}.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\Roman{section}.\arabic{subsection}.\arabic{subsection}}
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

\newcommand{\MakeThEnv}[8]{
    % args : env-name, title, style, color, rightline, leftline, topline, bottomline

    \DefaultFrame{#1}{#4}{#5}{#6}{#7}{#8}

    \theoremstyle{#3}
    \newtheorem{#1T}{#2}

    \newenvironment{#1}{\begin{#1Box}\begin{#1T}}{\end{#1T}\end{#1Box}}
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

    \newenvironment{#1s}{\begin{#1Boxs}\begin{#1Ts}\hfill\begin{enumerate}[wide, label={#9}]}{\end{enumerate}\end{#1Ts}\end{#1Boxs}}
}% makes theorem-style environments (itemized)

\newcommand{\MakeDmEnv}[1]{
    \DefaultFrame{demo}{#1}{false}{false}{false}{false}
    \newenvironment{demo}{\begin{demoBox}\begin{proof}}{\end{proof}\end{demoBox}}
}% makes proof environment
% ----------------------

% ----------------------
% HOLES-IN-TEXT MAKER
\RequirePackage{multido}

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

% Replace a word by a blank.
\def\Trouer#1{%
	\if@prof{#1}%                % If it is the "Teacher" mode, then the hidden word is displayed.
	\else
        \settowidth\wordlength{#1}   % Take the length of the word
        \addtolength\wordlength{2em} % Add 2em to the length
        \dotline{\wordlength}  % Otherwise we display a dotted line.
	\fi
}

% Replace a line by a blank.
\newcommand\TrouerL[2][1]{%
    \setcounter{lines}{#1}
	\if@prof {#2}%                                                                      % If it is the "Teacher" mode, then the hidden line is displayed.
	\else
        \ifnum\value{lines}>1                                                          % Otherwise we display dotted lines.
            \addtocounter{lines}{-1}
            \Dotfill\endgraf
            \multido{}{\value{lines}}{\noindent\makebox[\textwidth]{\Dotfill}\endgraf}
        \else \Dotfill                                                                 % Case of a single line.
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

	    \MakeThEnv{defin}{Définition}{definition}{defini}{false}{true}{false}{true}
        \MakeThEnvStar{defin}{Définition}{definition}{defini}{false}{true}{false}{true}

        \MakeThEnvStar{rem}{Remarque}{remark}{rema}{false}{true}{false}{false}
	    \MakeThEnv{rem}{Remarque}{remark}{rema}{false}{true}{false}{false}
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
        \MakeMultEnv{meths}{Méthode}{definition}{fg}{false}{true}{true}{false}{\textbf{\arabic*.}}

	    \MakeDmEnv{bg}
        \newenvironment{rep}{\begin{demo}[Réponse]}{\end{demo}}
        \newenvironment{reps}{\begin{demo}[Réponses]}{\end{demo}}
}

% Option commands in "options.sty" file

\input{../MyCourse/ceri/sty/options.sty}
% ----------------------

% ----------------------
% FINISH
% \ExecuteOptions{bluehoney} % Default color palette
\ProcessOptions\relax
% ----------------------