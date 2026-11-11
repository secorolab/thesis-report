%
% LaTeX2e class for bachelor and master thesis reports
% SECORO, University of Bremen, Germany
% Please feel free to send issues, suggestions or pull requests to:
% https://github.com/secorolab/thesis-report
% Based on the template by Argentina Ortega Sainz and Ronni Hartanto
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis_report}[2026/11/11 The SECORO thesis report class]

\newcommand*{\thesistype}[1]{\gdef\@thesistype{#1}%
}
\newcommand*{\@thesistype}{\texttt{\string\thesistype} not set. Please select the bachelor or master option}

\newcommand*{\degree}[1]{\gdef\@degree{#1}%
}
\degree{}

% Options
\DeclareOption{master}{\thesistype{Master Thesis}\degree{Master of Science}}
\DeclareOption{bachelor}{\thesistype{Bachelor Thesis}\degree{Bachelor of Science}}

% Report options
\DeclareOption{twoside}{
    \PassOptionsToClass{\CurrentOption}{book}
    \PassOptionsToPackage{left=3cm,right=2cm}{geometry}
}
\DeclareOption{oneside}{
    \PassOptionsToClass{\CurrentOption}{book}
    \PassOptionsToPackage{left=3cm,right=2cm,asymmetric}{geometry}
}

% Execute the default options
\ExecuteOptions{master,twoside}

% Process other options
\ProcessOptions\relax

% Load class options
\LoadClass[10pt,a4paper]{book}

%-------------------------------------------------------------------------------
%	VARIOUS REQUIRED PACKAGES AND CONFIGURATIONS
%-------------------------------------------------------------------------------

\RequirePackage[T1]{fontenc} % Proper hyphenation and copyable text for accented characters
\RequirePackage{lmodern} % Scalable Latin Modern fonts
\RequirePackage[english]{babel} % Hyphenation patterns
\RequirePackage{csquotes} % Context-sensitive quotes, recommended by biblatex
\RequirePackage{xcolor}
\RequirePackage{graphicx} % Required to include images
\RequirePackage{amsmath,amssymb,amsthm} % Math packages
\RequirePackage{bm} % Required for showing math symbols in boldface
\RequirePackage{listings} % Required for including snippets of code
\RequirePackage{booktabs} % Required for better horizontal rules in tables
\RequirePackage{multirow} % Required to enable merging of columns/rows in a table
\RequirePackage{rotating} % Required to display sideways tables/figures
\RequirePackage{subcaption} % Required for sub-figures
\RequirePackage{microtype} % Slightly tweak font spacing for aesthetics
\RequirePackage{geometry}
\RequirePackage[titletoc]{appendix}
\RequirePackage{setspace}
\RequirePackage{subfiles} % Chapters in separate files
\RequirePackage{titling} % Provides \theauthor and \thetitle
\RequirePackage{pdfpages} % Include the signed declaration PDF
\RequirePackage[nottoc]{tocbibind} % List of figures/tables in the table of contents
\RequirePackage{url}
\RequirePackage[backend=biber,style=numeric-comp,backref=true]{biblatex} % Add sources with \addbibresource in the document

\onehalfspacing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definitions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\thirdpartylogo}[1]{\def\@thirdpartylogo{#1}}
\thirdpartylogo{}

\newcommand*{\supervisors}[1]{\gdef\@supervisors{#1}%
}
\newcommand*{\@supervisors}{\texttt{\string\supervisors} currently
not set. Please fix this.}

\newcommand*{\faculty}[1]{\gdef\@faculty{#1}%
}
\faculty{Faculty 3 -- Mathematics and Computer Science}

\newcommand*{\studyprogram}[1]{\gdef\@studyprogram{#1}%
}
\newcommand*{\@studyprogram}{\texttt{\string\studyprogram} currently
not set. Please fix this.}

% PDF Metadata
\newcommand*{\keywords}[1]{\def\@keywords{#1}}
\keywords{}
\newcommand*{\subject}[1]{\def\@subject{#1}}
\subject{}

% Colors
\definecolor{unibremen}{HTML}{D50B2E} % Red of the Universit\"at Bremen logo

\definecolor{keywords}{RGB}{0,100,0}
\definecolor{comments}{RGB}{0,100,50}
\definecolor{stringred}{RGB}{160,0,0}
\definecolor{codeblue}{RGB}{0,0,150}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand*{\maketitle}{%
% The title page has no page number, so it gets no PDF page anchor to avoid
% duplicate hyperref destinations
\hypersetup{pageanchor=false}
\begin{titlepage}
    \newgeometry{left=3cm, bottom=3cm}

    \begin{minipage}{0.475\textwidth}
        \centering
        \includegraphics[height=1.5cm]{images/UniBremen_Logo.png}
    \end{minipage}
    \begin{minipage}{0.475\textwidth}
        \centering
        \includegraphics[height=1.5cm]{images/secoro-logo-horizontal-v2.png}
    \end{minipage}
    \centering
    \vfill
    \ifx\@thirdpartylogo\@empty
    \relax
    \else
    \begin{minipage}{0.4\textwidth}
        \centering
        \includegraphics[height=1.3cm]{\@thirdpartylogo}
    \end{minipage}

    \fi%

\vfill
{\Large\@thesistype\unskip\strut\par}
\vspace{1.5cm}
{\huge\bfseries\@title\unskip\strut\par}
\vspace{2cm}
{\Large\itshape\@author\unskip\strut\par}
\vfill

{\normalsize Submitted to the University of Bremen,\\
\@faculty\\
in partial fulfilment of the requirements for the degree\\
of \@degree\ in \@studyprogram}
\vfill

Supervised by\par
\vskip 8pt
{\large
\@supervisors\unskip\strut\par
}
\vfill

{\large \@date\par}
\end{titlepage}
\restoregeometry
\hypersetup{pageanchor=true}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Declaration of authorship
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The Eigenständigkeitserklärung (declaration of authorship) form from the
% Prüfungsamt is included as a flattened PDF; pdfTeX drops form fields, so the
% fillable form itself cannot be included. Page 1 of the official form only
% contains notes, so only the declarations on pages 2-4 are included by
% default.
\newcommand*{\declarationfile}[1]{\gdef\@declarationfile{#1}%
}
\declarationfile{declaration/Eigenstaendigkeitserklaerung.pdf}

\newcommand*{\declarationpages}[1]{\gdef\@declarationpages{#1}%
}
\declarationpages{2-4}

\newcommand*{\declarationpage}{%
\cleardoublepage
\includepdf[pages={\@declarationpages},pagecommand={\thispagestyle{empty}}]{\@declarationfile}
\cleardoublepage
}

%%%%%%%%%%%%%%%%%%%%
% Copyright page
%%%%%%%%%%%%%%%%%%%%

\def\copyrightpage#1{%
    \hbox{ }
    \vfill
    \begin{center}
        \copyright\ #1~\@author.~All Rights Reserved \\ [12pt]
    \end{center}
    \clearpage
}%


%%%%%%%%%%%%%%%%%%%%%
% Abstract
%%%%%%%%%%%%%%%%%%%%%

\newenvironment{abstract}{%
\chapter*{Abstract}
}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%
% Acknowledgements
%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{acknowledgements}{%
\chapter*{Acknowledgements}
}{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header and footer
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\setlength{\headheight}{14pt}

%% Page style for title pages.
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0pt}
    \renewcommand*\footrulewidth{0pt}
    \fancyfoot[C]{\thepage}
}

%% Fancy style for the main matter.
\fancypagestyle{mainmatter}{%
    \fancyhf{}
    \renewcommand*\headrulewidth{0.5pt}
    \fancyfoot[C]{\thepage}
    %% Section name on the right (even) page.
    \fancyhead[RE]{\nouppercase{\rightmark}}
    %% Chapter name on the left (odd) page.
    \fancyhead[LO]{\nouppercase{\leftmark}}
}

%% Print the current chapter and section at the top of the page.
\renewcommand*\chaptermark[1]{\markboth{\thechapter.\ #1}{}}
\renewcommand*\sectionmark[1]{\markright{\thesection.\ #1}}

%% Chapter titles have the same layout as parts.
\titleformat{\chapter}
    [display] % sectioning paragraph shape
    {\flushright}% format to be applied to the title, label, and text
    {\color{gray}\fontsize{68pt}{68pt}\selectfont\bfseries\thechapter}% sectioning label
    {0pt}% horizontal separation between label and title body and it must be a length and not be empty.
    {\Huge\color{black}}% code preceding the title body
    [\vspace{1cm}] % code following the title body (optional)

\titlespacing{\chapter}{0pt}{-50pt}{\baselineskip}

\titleformat{\section}
    [block]
    {\flushleft}%format
    {}%label
    {0pt}%sep
    {\bfseries\large\thesection~}%before code

\titlespacing{\section}{0pt}{0pt}{5pt}

\titleformat{\subsection}[display]
    {\flushleft}%format
    {}%label
    {0pt}%sep
    {\bfseries\large\thesubsection~}%before code

\titlespacing{\subsection}{0pt}{0pt}{2pt}

\renewcommand{\vec}[1]{\bm{#1}}

\RequirePackage[bookmarksnumbered,bookmarksopen,hidelinks]{hyperref} % PDF bookmarks (viewer outline) and links; load last

% Fill the PDF metadata from the title page fields
\AtBeginDocument{\hypersetup{pdftitle={\@title}, pdfauthor={\@author}, pdfsubject={\@subject}, pdfkeywords={\@keywords}}}

\endinput
