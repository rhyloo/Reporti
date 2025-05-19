\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reporti}[Template LaTeX based on Texas Instruments note application documentation.]

% ========================
% 1. Opciones de Clase
% ========================
\DeclareOption{draft}{
    \PassOptionsToPackage{draft}{graphicx}
    \AtEndOfClass{\usepackage{draftwatermark}\SetWatermarkText{BORRADOR}}
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% ========================
% 2. Herencia y Paquetes
% ========================
\LoadClass[10pt, a4paper, twoside]{article}

\RequirePackage{xparse}        % Para comandos avanzados
\RequirePackage{geometry}      % Configuración de márgenes
\RequirePackage{fancyhdr}      % Encabezados/pies de página
\RequirePackage{titlesec}      % Estilos de secciones
\RequirePackage{graphicx}      % Manejo de imágenes
\RequirePackage[spanish]{babel}% Localización
\RequirePackage{hyperref}      % Hipervínculos
\RequirePackage{fontspec}      % Fuentes modernas
\RequirePackage{datetime2}     % Manejo de fechas profesional
\RequirePackage{xcolor}        % Manejo de colores
\RequirePackage{etoolbox}      % Utilidades de macros

% Configuración de datetime2 para español
\DTMsetup{useregional=numeric}
%% \DTMlangsetup[spanish]{%
%%   month={Enero,Febrero,Marzo,Abril,Mayo,Junio,%
%%          Julio,Agosto,Septiembre,Octubre,Noviembre,Diciembre}
%% }

% ========================
% 3. Diseño de Página
% ========================
\renewcommand{\sectionmark}[1]{\markright{#1}}

\setlength{\headheight}{33pt} % 32.05278pt mínimo requerido + margen de seguridad
\geometry{top=3cm, bottom=2.5cm, left=1.83cm, right=1.83cm, footskip=1.2cm}

\fancypagestyle{mainstyle}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{2pt}
  \renewcommand{\footrulewidth}{1.5pt}
  \fancyhead[RE,LO]{\includegraphics[height=1cm]{Logo-EII-horizontal.pdf}}
  \fancyhead[LE,RO]{\nouppercase{\rightmark}}
  \fancyfoot[LE]{{\fontsize{8}{35}\selectfont \thepage \hspace{0.8cm} \itshape\@titulo}}
  \ifdefvoid{\@contact}{\fancyfoot[RE,LO]{{\fontsize{8}{35}\selectfont \ifdefvoid{\@code}{}{\@code}}}}{%
    \fancyfoot[RE,LO]{{\fontsize{8}{35}\selectfont \ifdefvoid{\@code}{}{\@code}\\\itshape\@contact}}
    }
  \fancyfoot[RO]{{\fontsize{8}{35}\selectfont  \itshape\@titulo \hspace{0.8cm} \thepage}}
}

\fancypagestyle{tocstyle}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{2pt}
  \renewcommand{\footrulewidth}{1.5pt}
  \fancyhead[RE,LO]{\includegraphics[height=1cm]{Logo-EII-horizontal.pdf}}
  \fancyhead[LE,RO]{}
  \fancyfoot[LE]{{\fontsize{8}{35}\selectfont \thepage \hspace{0.8cm} \itshape\@titulo}}
  \ifdefvoid{\@contact}{\fancyfoot[RE,LO]{{\fontsize{8}{35}\selectfont \ifdefvoid{\@code}{}{\@code}}}}{%
    \fancyfoot[RE,LO]{{\fontsize{8}{35}\selectfont \ifdefvoid{\@code}{}{\@code}\\\itshape\@contact}}
    }
  \fancyfoot[RO]{{\fontsize{8}{35}\selectfont  \itshape\@titulo \hspace{0.8cm} \thepage}}
}

% --- Redefinir marcas para ignorar subsecciones ---
\renewcommand{\sectionmark}[1]{\markright{\thesection\hspace{0.5em}#1}} % Actualiza solo \rightmark
\renewcommand{\subsectionmark}[1]{} % Subsecciones no modifican los headers


% --- Definir toggle ---
\newtoggle{InTocLoTLoF} % Controla TOC/LOT/LOF

% --- Configurar hook condicional ---
\AddToHook{cmd/section/before}{%
  \iftoggle{InTocLoTLoF}{}{\clearpage} % \clearpage solo fuera de TOC/LOT/LOF
}

% --- Redefinir comandos TOC/LOT/LOF (unificar cambios) ---
\let\oldtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{%
  \begingroup
  \toggletrue{InTocLoTLoF} % Activar toggle
  \thispagestyle{tocstyle} % Estilo de página específico
  \renewcommand{\baselinestretch}{1} % Ajuste principal (20% más de espacio)
  \setlength{\parskip}{0pt}
  \oldtableofcontents
  \endgroup
  \pagestyle{mainstyle} % Restaurar estilo
}

\let\oldlistoftables\listoftables
\renewcommand{\listoftables}{%
  \begingroup
  \toggletrue{InTocLoTLoF} % Activar toggle
  \thispagestyle{tocstyle} % Estilo de página específico
  \renewcommand{\baselinestretch}{1} % Ajuste principal (20% más de espacio)
  \setlength{\parskip}{0pt}
  \oldlistoftables
  \endgroup
  \pagestyle{mainstyle} % Restaurar estilo
}

\let\oldlistoffigures\listoffigures
\renewcommand{\listoffigures}{%
  \begingroup
  \toggletrue{InTocLoTLoF} % Activar toggle
  \renewcommand{\baselinestretch}{1} % Ajuste principal (20% más de espacio)
  \setlength{\parskip}{0pt}
  \thispagestyle{tocstyle} % Estilo de página específico
  \oldlistoffigures
  \endgroup
  \pagestyle{mainstyle} % Restaurar estilo
}


%% \AddToHook{cmd/section/before}{\clearpage}

\pagestyle{mainstyle}


\fancypagestyle{titlepagestyle}{
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{1.5pt}
  \fancyhf{}
  \fancyfoot[LE]{{\fontsize{8}{35}\selectfont \thepage \hspace{0.8cm} \itshape\@titulo}}
  \ifdefvoid{\@contact}{  \fancyfoot[RE,LO]{{\fontsize{8}{35}\selectfont \ifdefvoid{\@code}{}{\@code}}}}{
  \fancyfoot[RE,LO]{{\fontsize{8}{35}\selectfont \ifdefvoid{\@code}{}{\@code}\\\itshape\@contact}}}
  \fancyfoot[RO]{{\fontsize{8}{35}\selectfont  \itshape\@titulo \hspace{0.8cm} \normalfont\thepage}}
}


% ========================
% 4. Document Font
% ========================
\setmainfont{FreeSans}
% ========================
% 4. Estilos de Títulos
% ========================
\setlength{\headsep}{5pt} % Ajusta según necesidad para evitar warnings
\titleformat{\section}{\bfseries}{\thesection}{0.75cm}{}
\titleformat{\subsection}{\bfseries}{\thesubsection}{0.75em}{}
\titleformat{\subsubsection}{\bfseries}{\thesubsubsection}{0.75em}{}

% ========================
% 5. Metadatos del Documento
% ========================
\newcommand{\@metadata}{} % Registro de metadatos

\NewDocumentCommand{\titulo}{m}{%
    \def\@titulo{#1}%
    \listadd{\@metadata}{Título: #1}%
}
\NewDocumentCommand{\autor}{m}{%
    \def\@autor{#1}%
    \listadd{\@metadata}{Autor: #1}%
}
\NewDocumentCommand{\fecha}{O{\DTMtoday}}{%
    \def\@fecha{#1}%
    \listadd{\@metadata}{Fecha: #1}%
}
\NewDocumentCommand{\resumen}{m}{%
    \def\@resumen{#1}%
    \ifx\@resumen\@empty\else
        \gappto\@afterabstract{\@printresumen}%
    \fi
}
\NewDocumentCommand{\subtitulo}{m}{%
    \def\@subtitulo{#1}%
    \listadd{\@metadata}{Subtítulo: #1}%  % Opcional: para mostrar en metadata
}
\NewDocumentCommand{\type}{m}{%
    \def\@type{#1}%
    \listadd{\@metadata}{Type: #1}%  % Opcional: para mostrar en metadata
}

\NewDocumentCommand{\code}{m}{%
    \def\@code{#1}%
    \listadd{\@metadata}{Code: #1}%  % Opcional: para mostrar en metadata
}
\NewDocumentCommand{\notes}{m}{%
    \def\@notes{#1}%
    \listadd{\@metadata}{Notes: #1}%  % Opcional: para mostrar en metadata
}
\NewDocumentCommand{\contact}{m}{%
    \def\@contact{#1}%
    \listadd{\@metadata}{Contact: #1}%  % Opcional: para mostrar en metadata
}
\NewDocumentCommand{\toc}{m}{%
    \def\@toc{#1}%
    \listadd{\@metadata}{TOC: #1}%  % Opcional: para mostrar en metadata
}


\newlength{\originalparskip}
% ========================
% 6. Cover
% ========================
\NewDocumentCommand{\cover}{O{width=0.8\textwidth} m}{%
  \begingroup % Grupo local para cambios de espaciado
  % Save the original parskip value
  \setlength{\originalparskip}{\parskip}
  \renewcommand{\baselinestretch}{0.4} % Ajuste principal (20% más de espacio)
  \renewcommand{\parskip}{\originalparskip} % Ajuste principal (20% más de espacio)
  \begin{titlepage}
  \thispagestyle{titlepagestyle} % <--- Aplica el footer
    % --------------------------
    % Cabecera con logo y datos institucionales
    % --------------------------
    \noindent\begin{minipage}[t]{0.4\textwidth}
    \includegraphics[#1]{#2} 
    %% \vspace{-1.5\baselineskip} % Alineación precisa
    \end{minipage}%
    \hfill
    \begin{minipage}[t]{0.6\textwidth}
      \vspace{-2\baselineskip} % Alineación precisa
      \raggedleft
      \ifdef{\@type}{\fontsize{14}{35}\selectfont\itshape\@type}{}\par
      \ifdef{\@code}{\fontsize{9}{35}\selectfont\itshape\@code}{}

    \end{minipage}
    
    \vspace{0.5\baselineskip} % Alineación precisa

    \begin{flushright}
      {\fontsize{18}{35}\selectfont\bfseries\itshape\@titulo}
    \end{flushright}
    \vspace*{-1\baselineskip} % Reduce espacio posterior
        {\rule{\textwidth}{2pt}}

        \noindent\begin{minipage}{0.7\textwidth}
        \raggedright
        \ifdef{\@autor}{%
          {\fontsize{10}{35}\selectfont\itshape\@autor}
        }{}
        \end{minipage}
        \hfill
        \begin{minipage}{0.25\textwidth}
        \raggedleft
        \ifdef{\@subtitulo}{%
          {\fontsize{10}{35}\selectfont\itshape\@subtitulo}
        }{}
        \end{minipage}

        % --------------------------
        % Resumen condicional
        % --------------------------
        \ifdefvoid{\@resumen}{}{%
          \vspace{0.75cm}

          \hspace{1.75cm}
          \begin{minipage}{13.6cm}
            \begin{center}
              \noindent{\bfseries ABSTRACT}
              \end{center}
            {\fontsize{10}{35}\selectfont\@resumen}\par
            {\rule{\textwidth}{1pt}}
          \end{minipage}
        }
        \ifdefvoid{\@toc}{}{%
          \vspace{0.75cm}

          \hspace{1.75cm}
          \begin{minipage}{13.6cm}
            {\fontsize{9}{35}\selectfont
            \tableofcontents
            \listoffigures
            \listoftables}
          \end{minipage}
        }
        \vfill
        \ifdefvoid{\@notes}{}{%
          \noindent\raggedright{\fontsize{8}{35}\selectfont\@notes\vspace{-1\baselineskip}}}
  \end{titlepage}
  \endgroup
  \clearpage
}


% ========================
% 7. Validación y Advertencias
% ========================
%% \AtBeginDocument{%
%%     \@ifundefined{@titulo}{\ClassWarning{midocumento}{Título no definido}}{}
%%     \@ifundefined{@autor}{\ClassWarning{midocumento}{Autor no definido}}{}
%%     \ifdef{\@subtitulo}{}{\ClassInfo{midocumento}{Subtítulo no definido}} 
%%     \@ifundefined{@fecha}{\def\@fecha{\DTMtoday}}{}
%% }


% ========================
% 9. Configuración de Hipervínculos
% ========================
\hypersetup{
    colorlinks = true,
    linkcolor = blue!70!black,
    urlcolor = blue!70!black,
    citecolor = green!60!black
}

\setlength{\parindent}{0pt}
\setlength{\baselineskip}{50pt}
\renewcommand{\baselinestretch}{1.2} % Ajuste principal (20% más de espacio)



\makeatletter
\apptocmd{\@afterheading}{
  \vspace{-1.2\baselineskip}
  \setlength{\parskip}{12pt}
  }{}{}
\makeatother

\addto\captionsspanish{%
  \renewcommand{\contentsname}{\centering {\hfill Contenido\hfill}}
\renewcommand{\listfigurename}{\hfill\bfseries\normalsize Lista de figuras\hfill}
\renewcommand{\listtablename}{\hfill\bfseries\normalsize Lista de tablas\hfill}
%% \renewcommand{\lstlistlistingname}{\hfill\bfseries\normalsize Lista de códigos\hfill}
}




%% ---------------------------------------
%% TODO
%% ---------------------------------------
%% Si no hay código eliminarlo y subir el feedback.
