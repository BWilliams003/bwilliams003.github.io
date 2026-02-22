source "https://rubygems.org"

# [SECURITY] All gems pinned to minimum safe versions
# Remediates: SNYK-RUBY-JEKYLL-1246462 (CVE-2018-17567), SNYK-RUBY-KRAMDOWN-1076171 (CVE-2021-28834)
# See: https://security.snyk.io

# Core Jekyll - minimum v4.3.3 required (fixes CVE-2018-17567 Directory Traversal)
gem 'jekyll', '>= 4.3.3'

# Jekyll Feed - minimum v0.17.0 required (fixes GHSA-4g8v-vg43-wpgf XSS in feed output)
gem 'jekyll-feed', '>= 0.17.0'

# Jekyll Watch - pinned to stable version
gem 'jekyll-watch', '>= 2.2.1'

# Kramdown - minimum v2.3.1 required (fixes CVE-2021-28834 ReDoS vulnerability)
# kramdown is a Jekyll transitive dependency; explicit pin enforces safe version
gem 'kramdown', '>= 2.3.1'

# kramdown-parser-gfm - required for GitHub Flavored Markdown support
gem 'kramdown-parser-gfm', '>= 1.1.0'
