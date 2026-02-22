source "https://rubygems.org"

# SECURITY FIX [LOW] SAST-005:
# Pinned all gem versions to prevent resolution of future vulnerable releases.
# OWASP A06:2021 - Vulnerable and Outdated Components
#
# Run `bundle update` periodically and audit with: bundle exec bundle-audit check --update

gem 'jekyll', '~> 4.3.4'       # Pinned from unpinned; 4.3.4 is current stable
gem 'jekyll-feed', '~> 0.17'   # Pinned from unpinned
gem 'jekyll-watch', '~> 2.2'   # Pinned from unpinned

# Required for Ruby 3.x compatibility (webrick removed from stdlib)
gem 'webrick', '~> 1.8'

# Optional: uncomment for dependency auditing in CI
# gem 'bundler-audit', '~> 0.9'
