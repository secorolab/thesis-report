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
\RequirePackage{enumitem} % Compact lists in the declarations
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
% English wording of the official declarations of the Prüfungsamt of Faculty 3
% (form "Eigenständigkeitserklärung BA MA deutsch englisch", Stand: 11/24).
% The wording has to be adopted unchanged.
\newcommand*{\firstname}[1]{\gdef\@firstname{#1}%
}
\newcommand*{\@firstname}{\texttt{\string\firstname} not set}
\newcommand*{\lastname}[1]{\gdef\@lastname{#1}%
}
\newcommand*{\@lastname}{\texttt{\string\lastname} not set}
\author{\@firstname\ \@lastname}

\newcommand*{\matriculationnumber}[1]{\gdef\@matriculationnumber{#1}%
}
\newcommand*{\@matriculationnumber}{\texttt{\string\matriculationnumber} not set}

% Choices: \declarationai{yes}, \declarationarchive{agree|after30|disagree},
% \declarationplagiarism{agree|disagree}; unset choices stay unticked
\newcommand*{\declarationai}[1]{\def\@declarationai{#1}}
\newcommand*{\declarationarchive}[1]{\def\@declarationarchive{#1}}
\newcommand*{\declarationplagiarism}[1]{\def\@declarationplagiarism{#1}}
\declarationai{}
\declarationarchive{}
\declarationplagiarism{}

% Ticked box if the choice #1 equals #2, followed by the text #3
\newcommand{\@declarationchoice}[3]{%
    \def\@tempa{#2}%
    \par\noindent\hangindent=1.8em\hangafter=1
    \makebox[1.8em][l]{\ifx#1\@tempa$\boxtimes$\else$\square$\fi}#3\par\smallskip
}

\newcommand{\@declarationheading}[1]{\par\medskip\noindent\textbf{#1}\par\smallskip}

\newcommand*{\declarationpage}{%
\cleardoublepage
% Same title font as the chapters, but with less spacing so that everything fits on one page
\begin{flushright}\Huge Declarations\end{flushright}
\enlargethispage{2\baselineskip}
\begingroup
\small
\singlespacing
\setlength{\parskip}{0pt}
\setlength{\parindent}{0pt}

\noindent\textbf{Declarations of Authorship and Consent for Checking with Plagiarism Software and the
Declaration of Publication for Bachelor's and Master's Thesis}

\medskip
\noindent
\begin{tabular}{@{}l@{\hspace{0.5em}}l@{\hspace{2em}}l@{\hspace{0.5em}}l@{\hspace{2em}}l@{\hspace{0.5em}}l@{}}
    Student ID: & \@matriculationnumber & Surname: & \@lastname & First Name: & \@firstname
\end{tabular}\par
\noindent Title of Thesis:\hspace{0.5em}\@title\par

\@declarationheading{A) Declaration of Authorship}
I hereby affirm that I have written the present work independently and have used no sources or aids other than
those indicated. All parts of my work that have been taken from other works, either verbatim or in terms of
meaning, have been marked as such, indicating the source. The same applies to drawings, sketches, pictorial
representations and sources from the Internet, including AI-based applications or tools. The work has not yet
been submitted in the same or a similar form as a final examination paper.
\par\smallskip
\@declarationchoice{\@declarationai}{yes}{I have used AI-based applications and/or tools and documented them in the appendix \enquote{Use of AI-based applications}.}

\@declarationheading{B) Declaration regarding the publication of bachelor's or master's thesis}
Two years after graduation, the thesis is offered to the archive of the University of Bremen for
permanent archiving. The following are archived:
\begin{enumerate}[label=\arabic*),nosep,leftmargin=1.8em]
    \item Master's theses with a local or regional focus, as well as per subject and academic year 10\% of all Master's thesis
    \item Bachelor's thesis for the first and last bachelor's degrees per subject and year.
\end{enumerate}
\smallskip
\@declarationchoice{\@declarationarchive}{agree}{I agree that my thesis may be viewed by third parties in the university archive for academic purposes.}
\@declarationchoice{\@declarationarchive}{after30}{I agree that my thesis may be viewed by third parties for academic purposes in the university archive after 30 years (in accordance with §7 para.~2 BremArchivG).}
\@declarationchoice{\@declarationarchive}{disagree}{I do not consent to my thesis being made available in the university archive for third parties to view for academic purposes.}

\@declarationheading{C) Declaration of consent for electronic checking of the work for plagiarism}
Submitted papers can be checked for plagiarism using qualified software in accordance with §~18 of the
General Section of the Bachelor's or Master's Degree Examination Regulations of the University of Bremen.
For the purpose of checking for plagiarism, the upload to the server is done using the plagiarism software
currently used by the University of Bremen.
\par\smallskip
\@declarationchoice{\@declarationplagiarism}{agree}{I agree that the work I have submitted and written will be stored permanently on the external server of the plagiarism software currently used by the University of Bremen, in a library belonging to the institution (accessed only by the University of Bremen), for the above-mentioned purpose.}
\@declarationchoice{\@declarationplagiarism}{disagree}{I do not consent to the work I submitted and wrote being permanently stored on the external server of the plagiarism software currently used by the University of Bremen, in a library belonging to the institution (accessed only by the University of Bremen), for the above-mentioned purpose.}
Consent to the permanent storage of the text is voluntary. Consent can be withdrawn at any time by making
a declaration to this effect to the University of Bremen, with effect for the future. Further information on the
checking of written work using plagiarism software can be found in the data protection and usage concept.
This can be found on the University of Bremen website.

\medskip
\noindent
With my signature, I confirm that I have read and understood the above explanations and confirm the
accuracy of the information provided.

\vspace{0.8cm}
\noindent
\begin{tabular}{@{}p{5cm}@{\hspace{2cm}}p{6cm}@{}}
    \hrule\vspace{2pt}Date & \hrule\vspace{2pt}Signature
\end{tabular}
\endgroup
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
