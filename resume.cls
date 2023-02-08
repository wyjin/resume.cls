% minimum resume/cv document class used by wyjin.
% references: section 3 used code from
%   https://tex.stackexchange.com/questions/93908/macro-for-declaring-variables-in-class-files

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2023/02/07 resume/cv document class]
\LoadClass{article}

% 0. paper options
\DeclareOption{letterpaper}{
    \setlength\paperheight{11in}
    \setlength\paperwidth{8.5in}}
\DeclareOption{a4paper}{
    \setlength\paperheight{297mm}
    \setlength\paperwidth{210mm}}

\ExecuteOptions{letterpaper}
\ProcessOptions\relax


% 1. font settings
\RequirePackage{newpxtext,newpxmath}


% 2. enabling hyperlink
\RequirePackage{hyperref}


% 3. providing the following macros for titling:
%       \author: name of author
%       \address: correspondence address 
%       \phone: phone number
%       \email: email address
%       \link: related links (personal page, linkedin, github, etc.)
\newcommand{\DeclareVariable}{%
  \@ifstar{\resume@DeclareVariable{\resume@mandatory@var}}
          {\resume@DeclareVariable{\resume@optional@var}}%
}

\newcommand{\resume@DeclareVariable}[2]{%
  \@namedef{resume@#2}{#1{#2}}%
  \@namedef{#2}##1{\@namedef{resume@#2}{##1}}%
}

\newcommand{\resume@mandatory@var}[1]{%
  \ClassError{resume}
    {Missing value for mandatory variable
     \expandafter\string\csname#1\endcsname}
    {You have to provide a value with
     \expandafter\string\csname#1\endcsname{...}}%
}
\newcommand{\resume@optional@var}[1]{%
  \ClassInfo{resume}
    {Missing value for optional variable
     \expandafter\string\csname#1\endcsname}%
}

\DeclareVariable{author}
\DeclareVariable{address}
\DeclareVariable{email}
\DeclareVariable{phone}
\DeclareVariable{link}

\RequirePackage{titling}
\renewcommand{\maketitle} {
    \begin{center} % 
    {\large\bfseries \resume@author}\\ % 
    {\resume@address}\\
    {\resume@phone \enspace $\bullet$ \enspace 
    \href{mailto:\resume@email}{\texttt{\resume@email}} \enspace $\bullet$ \enspace 
    \href{\resume@link}{\texttt{\resume@link}}}
    \end{center}
}


% 4. section title styles
\RequirePackage{titlesec}
\titlespacing{\section}{0em}{0.5em}{0.5em}
\titleformat{\section}
    {\large\bfseries} %
    {} %
    {0em} %
    {} %
    [\titlerule] %


% 5. page and paragraph settings
\RequirePackage{geometry}
\geometry{
         letterpaper,
         left=0.5in,
         right=0.5in,
         top=0.5in,
         bottom=0.5in
}
\RequirePackage[parfill=0pt]{parskip}
\pagestyle{empty}

\RequirePackage{parskip}
\setlength{\parskip}{0.3em}

% 6. list styles
\newenvironment{cvlist}
{
\begin{list}{$\circ$}{\leftmargin=1em} 
    \itemsep -0.2em
}
{\end{list}}


% 7. custome environments
%   7.1 edhistory: environment for education
\newenvironment{edhistory}[6]{
    { #1}\hfill{#2}%
  \\
  {\em #3} \hfill {#4}\\
  {#5} \hfill {#6}

}{}  

%   7.2 cventry: environment for resume content, with a bullet list
\newenvironment{cventry}[4]{
    { \bf #1}\hfill{#2}%
  \\
  {\em #3} \hfill {#4}\\
  \vspace{-1.3em}
  \begin{cvlist}
   }{
   \end{cvlist}
}{}  
%   7.3 cvpar: environment for a paragraph, with hanging indent
\newenvironment{cvpar}[1][\empty]{\begingroup
\hangindent=2em
\hangafter=1
#1
}{\par%
\endgroup}


% 8. bibtex
\RequirePackage{natbib}
\setlength{\bibhang}{2em}
\newcommand{\cvbib}[1]{
    \begingroup 
        \renewcommand\@biblabel[1]{}
        \renewcommand{\section}[2]{}
        \bibliography{#1}
        \bibliographystyle{unsrtnat}
    \endgroup
}