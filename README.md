# SECORO thesis report

LaTeX template for bachelor and master thesis reports at [SECORO](https://secoro.uni-bremen.de/), University of Bremen.

Select the thesis type via the class option, `\documentclass[master]{thesis_report}` or `\documentclass[bachelor]{thesis_report}`.

The template is configured to be printed two-sided by default; this can be changed to a supervisor's preference by passing the option `oneside` instead, e.g. `\documentclass[master,oneside]{thesis_report}`.

The logo of an external institution can be added with the command `\thirdpartylogo{path/to/image}`.

If you are looking for the thesis proposal template, please head over to https://github.com/secorolab/thesis-proposal.

## Usage

The main file of the report is `thesis.tex`; chapters, appendices, and the abstract are given in separate files in the `chapters` directory.

The PDF has to be named according to the naming convention, i.e. your matriculation number (Matrikelnummer), first name (Vorname) and last name (Nachname) separated by underscores, e.g. `1234567_John_Doe.pdf`. Set this name once in `.latexmkrc`:

```perl
$jobname = '1234567_John_Doe';
```

See the [Studienzentrum Informatik page on the final phase of studies](https://www.uni-bremen.de/fb3/studium/studienberatung-studienzentrum/studienzentrum-informatik/studienabschlussphase) for the submission requirements.

## Building

Build the PDF with

```bash
latexmk thesis.tex
```

latexmk reads `.latexmkrc` and writes the PDF under the name set there. Other build tools (e.g. running `pdflatex` directly, or Overleaf, which always produces `output.pdf`) ignore it, so rename the PDF before submitting in that case.

The bibliography uses biblatex with biber; only works cited with `\cite` appear in the references.

## Note About Naming Your Chapters and Sections

The chapter and section names here are very generic since this is a template; however, feel free to modify them/make them more concrete based on your needs! In other words, the names in your report don't have to be the same as in the template (although you will want to keep at least the names of the introduction, state of the art, and conclusions chapters unchanged).
