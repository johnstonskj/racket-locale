#lang scribble/manual

@(require scribble/core racket/file)

@;{============================================================================}

@title[#:version "1.0"]{Package racket-locale}
@author[(author+email "Simon Johnston" "johnstonskj@gmail.com")]

This package provides access to operating system locale configuration, and
specifically the C runtime @tt{setlocale} and @tt{localeconv} functions. It
also implements higher-level formatting functions for dates, numbers, and
currency values.

@table-of-contents[]

@include-section["locale.scrbl"]

@include-section["language-info.scrbl"]

@include-section["format.scrbl"]

@section{License}

@verbatim|{|@file->string["../LICENSE"]}|
