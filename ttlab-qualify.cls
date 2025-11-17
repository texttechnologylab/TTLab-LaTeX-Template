%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TTLAB-Qualifikations- und -Hausarbeiten
% Version 1.0 (6/6/16)
% Version 1.1 (15/01/24)
% Version 1.2 (21/10/25)
%
% Author:
% Andy Lücking
% Manuel Schaaf
%
% License:
% CC BY-SA 4.0 http://creativecommons.org/licenses/by-sa/4.0/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ttlab-qualify}[21/10/2025, v1.1 LaTeX-Vorlage für Qualifikations- und Hausarbeiten am Text Technology Lab]

\RequirePackage{babel}
\RequirePackage{etoolbox}
\newbool{minted}
\newbool{mintedframed}
\newbool{tcolorbox}
\newbool{nomencl}
\newbool{algorithm}
\newbool{nolibertine}
%%%
\newbool{bsc2019}
\newbool{msc2019}
\newbool{mscbio2019}
\newbool{mscwirtschaft2019}
\newbool{seminar}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrreprt}}

%%% Packages:
\DeclareOption{minted}{
    \booltrue{minted}
}
\DeclareOption{mintedframed}{
    \booltrue{mintedframed}
}

\DeclareOption{tcolorbox}{
    \booltrue{tcolorbox}
}

\DeclareOption{nomencl}{
    \booltrue{nomencl}
}

\DeclareOption{algorithm}{
    \booltrue{algorithm}
}

\DeclareOption{nolibertine}{
    \booltrue{nolibertine}
}

%%% Studiengang:
\DeclareOption{bsc2019}{
    \booltrue{bsc2019}
}
\DeclareOption{msc2019}{
    \booltrue{msc2019}
}
\DeclareOption{mscbio2019}{
    \booltrue{mscbio2019}
}
\DeclareOption{mscwirtschaft2019}{
    \booltrue{mscwirtschaft2019}
}
\DeclareOption{seminar}{
    \booltrue{seminar}
}

%%% Options:
\DeclareOption{ngerman}{
    \PassOptionsToPackage{\CurrentOption}{babel}
}

\DeclareOption{english}{
    \PassOptionsToPackage{\CurrentOption}{babel}

    % Writing the thesis in English requires an additional German abstract!
    \newtoggle{includesZusammenfassung}

    \AfterEndDocument{
        \iftoggle{includesZusammenfassung}
        {}
        {\ClassError{ttlab-qualify}{English theses require a German abstract! Add a 'zusammenfassung' environment in addition to your abstract}{}}
    }

    \newenvironment{zusammenfassung}
    {
        \global\toggletrue{includesZusammenfassung}%
        \let\oldabstractname\abstractname%
        \renewcommand{\abstractname}{Zusammenfassung}%
        \begin{abstract}
            }{
        \end{abstract}
        \let\abstractname\oldabstractname
    }
}

\DeclareOption*{%
    \PassOptionsToClass{\CurrentOption}{scrreprt}
}

\ExecuteOptions{ngerman}
\ExecuteOptions{pagesize=auto}
\ExecuteOptions{paper=a4}

\ProcessOptions*\relax

\LoadClass[
    titlepage=on,
    fontsize=12pt,
    bibliography=totoc,
    headings=small,
    headsepline,
    footsepline,
    abstract=true,
    toc=listof,
    listof=flat,
    parskip=half
]{scrreprt}
\RequirePackage{tocbasic}
\KOMAoption{captions}{tableheading,figuresignature}
\addtokomafont{minisec}{\normalsize}

% Set-up desired margins
\RequirePackage[left=2.5cm,right=2.5cm,top=2.0cm,bottom=2.0cm,includeheadfoot]{geometry}

% Horizontal lines for header & footer (none on title pages or above chapter headings)
\pagestyle{headings}

% 3 levels of section nestings
\setcounter{secnumdepth}{3}
% but only show two in the table of contents
\setcounter{tocdepth}{2}
% Continuous footnote numbers
\counterwithout{footnote}{chapter}

%%% Font:
\RequirePackage{iftex}
\ifPDFTeX
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
\else
    \ifXeTeX
        \ClassWarning{ttlab-qualify}{Use LuaLaTeX instead of XeLaTeX}
    \fi
    \RequirePackage{fontspec}
\fi

\ifbool{nolibertine}{}{
    \ifPDFTeX
        \RequirePackage{libertine} % serif and sans-serif fonts
        \RequirePackage[scaled=0.785]{DejaVuSansMono} % monospace font
    \else
        \setromanfont[Ligatures=TeX]{Linux Libertine O} % serif font
        \setsansfont[Ligatures=TeX]{Linux Biolinum O} % sans-serif font
        \setmonofont[Scale=MatchLowercase]{DejaVu Sans Mono} % monospace font
    \fi
}

%%% Load some useful packages:
\RequirePackage[autostyle=true]{csquotes}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage[style=authoryear, citestyle=authoryear, maxnames=5, maxcitenames=3, backend=biber, natbib=true]{biblatex}

\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,
    anchorcolor=blue,
    linkcolor=blue,
    citecolor=blue,
    filecolor=magenta,
    urlcolor=blue,
}

\RequirePackage{tabularray}
\UseTblrLibrary{booktabs}
% Required for verbatim in tblr with \fakeverb
\RequirePackage{codehigh}

\ifbool{minted}{
    \RequirePackage{newfloat}
    \RequirePackage[newfloat=true]{minted}
    \setminted{
        fontsize=\footnotesize,
        linenos,    % number lines
        autogobble, % autmatically remove indents for better readability
        breaklines, % break long lines
    }
    \SetupFloatingEnvironment{listing}{
        name=Listing,
        listname=List of Listings,
        placement=!h,
        within=chapter,
    }
    \RequirePackage{subcaption}
    \captionsetup[listing]{position=top,skip=-4pt}

    % Add frames around all minted environments
    \ifbool{mintedframed}{
        \RequirePackage{mdframed}
        % Use novalidate to silence Overleaf's syntax check
        %%begin novalidate
        \BeforeBeginEnvironment{minted}{\begin{mdframed}[rightline=false,leftline=false,linewidth=0.6pt]}
        \AfterEndEnvironment{minted}{\end{mdframed}}
        %%end novalidate
    }{}
}{}
\ifbool{tcolorbox}{
    \RequirePackage{tcolorbox}
    \tcbuselibrary{skins}
    \ifbool{minted}{
        \tcbuselibrary{minted}
        \tcbset{
            default minted options={
                fontsize=\footnotesize,
                linenos,    % number lines
                autogobble, % autmatically remove indents for better readability
                breaklines, % break long lines
            }
        }
    }{}
}{}
\ifbool{nomencl}{\RequirePackage[intoc]{nomencl}\makenomenclature}{}
\ifbool{algorithm}{\RequirePackage[linesnumbered]{algorithm2e}}{}

% Erklärungen from Prüfungsamt:
\newcommand{\Studiengang}{gemäß \textcolor{red}{wähle Studiengang!}}
\newcommand{\BorM}{\textcolor{red}{X}}
\ifbool{bsc2019}{\renewcommand{\Studiengang}{gemäß \S 35, Abs. 16 der Ordnung für den Bachelorstudiengang Informatik vom 17. Juni 2019:}\renewcommand{\BorM}{Bachelor}}{}
\ifbool{msc2019}{\renewcommand{\Studiengang}{gemäß \S 34, Abs. 16 der Ordnung für den Masterstudiengang Informatik vom 17. Juni 2019:}\renewcommand{\BorM}{Master}}{}
\ifbool{mscbio2019}{\renewcommand{\Studiengang}{gemäß \S 35, Abs. 16 der Ordnung für den Masterstudiengang Bioinformatik vom 17. Juni 2019:}\renewcommand{\BorM}{Master}}{}
\ifbool{mscwirtschaft2019}{\renewcommand{\Studiengang}{gemäß \S 34, Abs. 16 der Ordnung für den Masterstudiengang Wirtschaftsinformatik vom 01. April 2019:}\renewcommand{\BorM}{Master}}{}
\ifbool{seminar}{\renewcommand{\Studiengang}{}\renewcommand{\BorM}{Seminar}}{}

\dedication{\textbf{\sffamily Erklärung zur Abschlussarbeit}
    \par\bigskip
    \begin{minipage}{\linewidth}\large
        \textbf{\Studiengang}\par\bigskip
        Hiermit erkläre ich
        \vskip1cm
        \rule{\linewidth}{0.6pt} \\
        (\textit{Nachname, Vorname})
        \par\bigskip

        Die vorliegende Arbeit habe ich selbstständig und ohne Benutzung anderer als der angegebenen Quellen und Hilfsmittel verfasst.\par\medskip

        Ich bestätige außerdem, dass die vorliegende Arbeit nicht, auch nicht auszugsweise, für eine andere Prüfung oder Studienleistung verwendet wurde.\par\medskip

        Zudem versichere ich, dass alle eingereichten schriftlichen gebundenen Versionen meiner vorliegenden \BorM arbeit mit der digital eingereichten elektronischen Version meiner \BorM arbeit übereinstimmen.\par\bigskip

        Frankfurt am Main, den \par\bigskip\bigskip
        \rule{4cm}{0.6pt} \hfill \rule{10cm}{0.6pt}\\
        Datum \hfill  Unterschrift der/des Studierenden
    \end{minipage}
}

% reduce fontsize in quotation environments:
\expandafter\def\expandafter\quote\expandafter{\quote\footnotesize}
\expandafter\def\expandafter\quotation\expandafter{\quote\footnotesize}

\endinput