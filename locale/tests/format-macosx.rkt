#lang racket/base
;;
;; racket-locale - format.
;;   More locale tools for Racket
;;   
;;
;; Copyright (c) 2018 Simon Johnston (simonjo@amazon.com).

;; ---------- Requirements

(require racket/bool
	 rackunit
	 ; ---------
	 locale
	 locale/format)

(when (equal? (system-type) 'macosx)

  ;; ---------- Test Fixtures

  (define locale-currency-samples (list (cons "sr_YU" "1 234,56din")
					(cons "tr_TR" "L 1.234,56")
					(cons "sv_SE" "1 234,56kr")
					(cons "fr_BE" "1.234,56Eu")
					(cons "fr_CA" "1 234,56$")
					(cons "fr_CH" "Fr. 1.234,56")
					(cons "fr_FR" "1 234,56Eu")
					(cons "et_EE" "1 234.56kr")
					(cons "af_ZA" "R 1.234,56")
					(cons "it_IT" "Eu 1.234,56")
					(cons "it_CH" "Fr. 1.234,56")
					(cons "no_NO" "kr 1.234,56")
					(cons "da_DK" "kr 1.234,56")
					(cons "he_IL" "שח 1,234.56")
					(cons "zh_HK" "HK$ 1,234.56")
					(cons "zh_CN" "￥ 1,234.56")
					(cons "zh_TW" "NT$ 1,234.56")
					(cons "nl_NL" "Eu 1 234,56")
					(cons "nl_BE" "1.234,56Eu")
					(cons "fi_FI" "1.234,56Eu")
					(cons "el_GR" "1.234,56Eu")
					(cons "sk_SK" "Sk 1 234,56")
					(cons "hi_IN" "Sk 1 234,56")
					(cons "bg_BG" "1 234,56лв.")
					(cons "pl_PL" "zł 1 234,56")
					(cons "hy_AM" "1,234.56ԴՐ  ")
					(cons "ko_KR" "₩ 1,234.")
					(cons "de_AT" "Eu 1 234,56")
					(cons "de_CH" "Fr. 1.234,56")
					(cons "de_DE" "Eu 1.234,56")
					(cons "eu_ES" "1.234,56Eu")
					(cons "es_ES" "1.234,56Eu")
					(cons "ru_RU" "1 234,56руб.")
					(cons "sl_SI" "1 234,56SIT")
					(cons "am_ET" "$ 1,234.56")
					(cons "kk_KZ" "1 234,56тг.")
					(cons "hu_HU" "Ft 1 234,56")
					(cons "ro_RO" "1 234,56Lei")
					(cons "ja_JP" "¥ 1,234.")
					(cons "lt_LT" "1 234,56Lt")
					(cons "en_IE" "€ 1,234.56")
					(cons "en_AU" "$ 1,234.56")
					(cons "en_CA" "$ 1,234.56")
					(cons "en_GB" "£ 1,234.56")
					(cons "en_NZ" "$ 1,234.56")
					(cons "en_US" "$ 1,234.56")
					(cons "be_BY" "1 234,56руб.")
					(cons "is_IS" "1.234,kr")
					(cons "hr_HR" "1 234,56Kn")
					(cons "pt_BR" "1.234,56R$")
					(cons "pt_PT" "1.234.56Eu")
					(cons "ca_ES" "Eu 1.234,56")
					(cons "cs_CZ" "1 234,56Kč")
					(cons "uk_UA" "1 234,56грн.")))

  ;; ---------- Test Cases
  
  (for ([test-locale-currency locale-currency-samples])
       (if (false? (set-locale (car test-locale-currency)))
	   (displayln (format "info: could not set locale to ~a, ignoring" (car test-locale-currency)))
	   (test-case
	    (format "format-currency: for local ~a" (car test-locale-currency))
	    (check-equal? (format-currency 1234.567) (cdr test-locale-currency))))))
