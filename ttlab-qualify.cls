%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TTLAB-Qualifikations- und -Hausarbeiten
% Version 1.0 (6/6/16)
% Version 1.1 (15/01/24)
%
% Author:
% Andy Lücking
%
% License:
% CC BY-SA 4.0 http://creativecommons.org/licenses/by-sa/4.0/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ttlab-qualify}[15/01/2024, v1.1 LaTeX-Vorlage für Qualifikations- und Hausarbeiten am Text Technology Lab]

\RequirePackage{babel}
\RequirePackage{etoolbox}
\newbool{minted}
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
}

\DeclareOption*{%
  \PackageWarning{ttlab-qualify}{Unknown option '\CurrentOption'}%
}

\ExecuteOptions{ngerman}
\ProcessOptions*\relax

\LoadClass[pagesize=auto, paper=a4, titlepage=on, fontsize=12pt, bibliography=totoc, headings=small, captions=tableheading]{scrreprt}

%%% Font:
\ifbool{nolibertine}{}{
  \RequirePackage{fontspec}
  \setromanfont[Mapping=tex-text]{Linux Libertine O} % Serifenschrift
  \setsansfont[Mapping=tex-text]{Linux Biolinum O} % serifenlose Schrift
  \setmonofont[Scale=MatchLowercase]{DejaVu Sans Mono}%
}

%%% Load some useful packages:
\RequirePackage[autostyle=true]{csquotes}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{mathtools}
\RequirePackage{amssymb}
\RequirePackage[style=authoryear, maxnames=5, maxcitenames=3, backend=biber]{biblatex}

\ifbool{minted}{\RequirePackage{minted}}{}
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