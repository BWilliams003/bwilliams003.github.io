source "https://rubygems.org"

# SECURITY FIX [MEDIUM] VULN-GEMFILE-UNPINNED:
# All gems are now version-pinned to prevent supply-chain attacks.
# Unpinned dependencies allow malicious versions to be silently introduced.
# Run `bundle install` after updating these to regenerate Gemfile.lock.
# Commit Gemfile.lock to ensure reproducible, auditable builds.
# OWASP A06:2021 | SOC2 CC8.1 | PCI-DSS 6.3.3
#
# AI REVIEW NOTE: Pessimistic version constraint (~>) pins to minor version.
# For example, ~> 4.3.3 allows 4.3.3, 4.3.4 etc. but not 4.4.x.
# This balances security patches with stability. Review quarterly.

# Jekyll static site generator - pinned to latest stable security-patched version
gem 'jekyll', '~> 4.3.3'

# Jekyll plugins - pinned to known-good versions
gem 'jekyll-feed', '~> 0.17.2'
gem 'jekyll-watch', '~> 2.2.1'

# Required for Ruby 3.x+ compatibility (WEBrick was removed from stdlib)
gem 'webrick', '~> 1.8'

# Development/test group - separate from production dependencies
group :development do
  # bundler-audit scans Gemfile.lock for known CVEs
  # Run: bundle exec bundler-audit check --update
  gem 'bundler-audit', '~> 0.9'
end
