# Racket package racket-locale

[![GitHub release](https://img.shields.io/github/release/johnstonskj/racket-locale.svg?style=flat-square)](https://github.com/johnstonskj/racket-locale/releases)
[![Travis Status](https://travis-ci.org/johnstonskj/racket-locale.svg)](https://www.travis-ci.org/johnstonskj/racket-locale)
[![Coverage Status](https://coveralls.io/repos/github/johnstonskj/racket-locale/badge.svg?branch=master)](https://coveralls.io/github/johnstonskj/racket-locale?branch=master)
[![raco pkg install racket-locale](https://img.shields.io/badge/raco%20pkg%20install-racket--locale-blue.svg)](http://pkgs.racket-lang.org/package/racket-locale)
[![Documentation](https://img.shields.io/badge/raco%20docs-racket--locale-blue.svg)](http://docs.racket-lang.org/racket-locale/index.html)
[![GitHub stars](https://img.shields.io/github/stars/johnstonskj/racket-locale.svg)](https://github.com/johnstonskj/racket-locale/stargazers)
![MIT License](https://img.shields.io/badge/license-MIT-118811.svg)



## Modules

* `locale` - basic locale functions, get/set the current locale as well as locale conventions.
* `locale/language-info` - additional locale information.
* `locale/format` - locale -aware formatting for numbers, currency, and dates,

## Example

```scheme
(require locale locale/format racket/date)
(set-locale "en_GB")

(format-date (current-date))
(format-number 1234567.89)
(format-currency 10.99)
```


## Installation

* To install (from within the package directory): `raco pkg install`
* To install (once uploaded to [pkgs.racket-lang.org](https://pkgs.racket-lang.org/)): `raco pkg install racket-locale`
* To uninstall: `raco pkg remove racket-locale`
* To view documentation: `raco docs racket-locale`

## History

* **1.0** - Initial Version

[![Racket Language](https://raw.githubusercontent.com/johnstonskj/racket-scaffold/master/scaffold/plank-files/racket-lang.png)](https://racket-lang.org/)
