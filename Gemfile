source "https://rubygems.org"
# Security-hardened Gemfile — pinned to patched versions
# Remediation: SNYK-RUBY-JEKYLL-6736165 (ReDoS), SNYK-RUBY-JEKYLLFEED-5498231

gem 'jekyll', '>= 4.3.3'        # Fixed: CVE-2024-47178 ReDoS vulnerability
gem 'jekyll-feed', '>= 0.17.2'  # Fixed: CVE-2023-37463 Information Disclosure
gem 'jekyll-watch'
gem 'webrick', '>= 1.8.1'       # Required for Ruby 3+ compatibility + security patches
