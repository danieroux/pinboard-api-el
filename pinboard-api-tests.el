(require 'ert)
(require 'pinboard-api)

(defun pinboard--test-xml-parse ()
  (with-temp-buffer
    (insert "<tags><tag count='1' tag='business' /><tag count='5' tag='xml' /><tag count='1' tag='xp' /></tags>")
    (xml-parse-region)))

(ert-deftest test-parse-tags ()
  (should (equal '("business" "xml" "xp") (pinboard-parse-tags (pinboard--test-xml-parse)))))

(ert-deftest test-build-request ()
  (should (equal "&url=http%3A%2F%2Fdanieroux.com&description=Home%20page&tags=personal%2Cblog" (pinboard-build-add-request "http://danieroux.com" "Home page" "personal,blog")))
  (should (equal "&url=http%3A%2F%2Fdanieroux.com" (pinboard-build-add-request "http://danieroux.com" nil nil)))
  (should (equal "&url=http%3A%2F%2Fdanieroux.com" (pinboard-build-add-request "http://danieroux.com" "" "")))
  (should (equal "&url=http%3A%2F%2Fdanieroux.com" (pinboard-build-add-request "http://danieroux.com")))
  (should-error (pinboard-build-add-request nil)))
